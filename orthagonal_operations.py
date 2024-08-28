import json
import subprocess

import oapackage
from openpyxl import Workbook
import os


def generate_testing_combinations(factors, levels, runs=None):
    """
    Generates testing combinations using an orthogonal array from oapackage.

    Args:
        factors (list): A list of strings representing the testing factors (e.g., ["Browser", "Device"]).
        levels (dict): A dictionary mapping each factor to a list of its possible levels (e.g., {"Browser": ["Chrome", "Firefox"]}).
        runs (int, optional): The desired number of test cases (rows in the orthogonal array).
            Defaults to None, which uses a suitable default based on oapackage behavior.

    Returns:
        list: A list of dictionaries, where each dictionary represents a test case combination.
    """
    if len(factors) != len(levels):
        raise ValueError("Number of factors must match the number of level dictionaries.")

    if runs is None:
        runs = find_suitable_runs(factors, levels)

    array_class = oapackage.arraydata_t(len(levels[factors[0]]), runs, len(factors), len(factors))
    array_link = array_class.create_root()
    generated_array = array_link.getarray()

    combinations = []

    for i in range(runs):
        combination = {}
        for j, factor in enumerate(factors):
            combination[factor] = levels[factor][generated_array[i][j] % len(levels[factor])]
        combinations.append(combination)

    return combinations



def find_suitable_runs(factors, levels):
    """
    Find a suitable number of runs (test cases) for the orthogonal array.

    This example implementation simply returns a placeholder value.
    Replace it with your logic to determine the optimal or desired number of runs
    based on factors, levels, and testing coverage requirements.

    Args:
        factors (list): A list of testing factors.
        levels (dict): A dictionary mapping factors to their levels.

    Returns:
        int: The estimated or desired number of test cases.
    """
    return 3


def commit_and_push_changes(branch, remote_url):
    # Add all changes to the staging area
    subprocess.run(["git", "add", "."], check=True)

    # Commit changes with a default message
    subprocess.run(["git", "commit", "-m", "Commit changes"], check=True)

    subprocess.run(["git", "checkout", branch], check=True)

    # Push changes to the specified branch on remote repository
    subprocess.run(["git", "push", "origin", branch], check=True)



def update_combinations(combinations, output_file="ios_combinations.json"):
    with open(output_file, 'w') as json_file:
        json.dump(combinations, json_file, indent=4)

