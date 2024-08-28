import json
import subprocess

from openpyxl import Workbook
import os

import orthagonal_operations


def generate_dockerfile_web(env_details, json_file, output_file, platform,dockerfiles_folder="web_dockerfiles"):

    if not os.path.exists(dockerfiles_folder):
        os.makedirs(dockerfiles_folder)

    dockerfile_content = f"""
FROM ubuntu:20.04

# Set the DEBIAN_FRONTEND to noninteractive to suppress prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the image and install system packages
RUN apt-get update && apt-get install -y \\
    python3 \\
    python3-pip \\
    wget \\
    xvfb \\
    zip \\
    ca-certificates \\
    libnss3-dev \\
    libasound2 \\
    libxss1 \\
    libappindicator3-1 \\
    libindicator7 \\
    gconf-service \\
    libgconf-2-4 \\
    libpango1.0-0 \\
    xdg-utils \\
    fonts-liberation \\
    wmctrl \\
    curl

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \\
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \\
    && apt-get update \\
    && apt-get install -y google-chrome-stable \\
    && apt-get clean \\
    && rm -rf /var/lib/apt/lists/* || true


# Install Robot Framework and SeleniumLibrary along with other required Python packages
RUN pip3 install selenium==4.15.2 \\
                 robotframework==6.1.1 \\
                 robotframework-seleniumlibrary==6.2.0 \\
                 robotframework-retryfailed==0.2.0 \\
                 robotframework-pabot==2.16.0 \\
                 openpyxl==3.1.2 \\
                 allure-robotframework==2.13.2 \\
                 webdrivermanager \\
                 pandas

# Install ChromeDriver using WebDriverManager
#RUN webdrivermanager chrome --linkpath /usr/local/bin

# Set the working directory
WORKDIR /robot

# Copy the current directory contents into the container at /robot
COPY . /robot

# Install additional Python dependencies
RUN pip install --no-cache-dir -r /robot/requirements.txt

# Copy the environment JSON file into the container at /robot/Runners/Environment/web_environment.json
COPY {json_file}.json /robot/Runners/Environment/{platform}_environment.json

# Set the default command to run Robot Framework with an option to specify tags
CMD ["robot", "--i", "Login", "/robot/Web/RR/TestCases"]
"""
    formatted_content = dockerfile_content.format(json_file=json_file, platform=platform)

    file_output_path = os.path.join(dockerfiles_folder, output_file)

    with open(file_output_path, 'w') as f:
        f.write(formatted_content.strip())
    print(f"Dockerfile written to '{file_output_path}'")


def update_web_environment_combinations(combinations, env_config):
    for index, combination in enumerate(combinations):
        env_key = combination.get('env', '').lower()
        browser_key = combination.get('browser', '').lower()

        if env_key in env_config['env'] and browser_key in env_config['browser']:
            updated_env = {
                "RR_application_url": env_config['env'][env_key],
                "browser": env_config['browser'][browser_key],
                "window_height": env_config['window_height'],
                "window_width": env_config['window_width'],
                "receiver_email": env_config['receiver_email']
            }

            output_file = f"updated_env_web_{index+1}.json"
            with open(output_file, 'w') as f:
                json.dump(updated_env, f, indent=2)

            print(f"Updated environment combination {index+1} for web written to '{output_file}'")

            dockerfile_output_file = f"Dockerfile_web_{index + 1}"
            generate_dockerfile_web(updated_env, output_file, dockerfile_output_file, "web")


if __name__ == "__main__":

    with open("web_environment.json", 'r') as f:
        combined_env = json.load(f)

    if 'web' in combined_env:
        factors = ["env", "browser"]
        levels = {
            "env": ["QA", "Staging", "Prod"],
            "browser": ["chrome", "edge", "firefox"]
        }

        test_combinations = orthagonal_operations.generate_testing_combinations(factors, levels)

        update_web_environment_combinations(test_combinations, combined_env['web'])

    remote_url = "https://github.com/PritiKakadeIndexnine/Execution_Demo.git"

    orthagonal_operations.commit_and_push_changes("web_Aws_Execution", remote_url)
