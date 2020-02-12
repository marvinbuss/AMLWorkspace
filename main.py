import os
import json
from azureml.core import Workspace
from azureml.exceptions import WorkspaceException
from azureml.core.authentication import AzureCliAuthentication


def main():
    # Loading input values
    print("::debug::Loading input values")
    parameters_file = os.environ.get("INPUT_PARAMETERSFILE", default=None)
    subscription_id = os.environ.get("INPUT_SUBSCRIPTIONID", default=None)

    # Loading parameters file
    print("::debug::Loading parameters file")
    parameters_file_path = os.path.join(".aml", parameters_file)
    try:
        with open(parameters_file_path) as f:
            parameters = json.load(f)
    except FileNotFoundError:
        print(f"::error::Could not find parameter file in {parameters_file_path}. Please provide a parameter file in your repository (e.g. .aml/workspace.json).")
        return

    # Loading Workspace
    cli_auth = AzureCliAuthentication()
    try:
        print("::debug::Loading existing Workspace")
        ws = Workspace.get(
            name=parameters.get("name", None),
            subscription_id=subscription_id,
            resource_group=parameters.get("resourceGroup", None),
            auth=cli_auth
        )
        print("::debug::Successfully loaded existing Workspace")
    except WorkspaceException as exception:
        print(f"::debug::Loading existing Workspace failed: {exception}")
        if parameters.get("createWorkspace", False):
            try:
                print("::debug::Creating new Workspace")
                ws = Workspace(
                    name=parameters.get("name", None),
                    subscription_id=subscription_id,
                    resource_group=parameters.get("resourceGroup", None),
                    location=parameters.get("location", None),
                    create_resource_group=parameters.get("createResourceGroup", False),
                    sku=parameters.get("sku", "basic"),
                    friendly_name=parameters.get("friendlyName", None),
                    storage_account=parameters.get("storageAccount", None),
                    key_vault=parameters.get("keyVault", None),
                    app_insights=parameters.get("appInsights", None),
                    container_registry=parameters.get("containerRegistry", None),
                    cmk_keyvault=parameters.get("cmkKeyVault", None),
                    resource_cmk_uri=parameters.get("resourceCmkUri", None),
                    hbi_workspace=parameters.get("hbiWorkspace", None),
                    auth=cli_auth
                )
            except WorkspaceException as exception:
                print(f"::error::Creating new Workspace failed: {exception}")
                return

    # Write Workspace ARM properties to config file
    print("::debug::Writing Workspace ARM properties to config file")
    config_file_path = os.environ.get("GITHUB_WORKSPACE", default=".aml")
    config_file_name = "aml_arm_config.json"
    ws.write_config(
        path=config_file_path,
        file_name=config_file_name
    )
    print("::debug::Successfully finised Azure Machine Learning Workspace Action")


if __name__ == "__main__":
    main()
