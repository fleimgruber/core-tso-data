from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()

configfile: "config.yaml"

rule retrieve_data:
    output: **{k: f"data/jao/Core _Static Grid Model_template_{k}.xlsx" for k in config['regions'].keys()}

rule process_data:
    input: **rules.retrieve_data.output
    output:
        buses='outputs/buses.csv',
        lines='outputs/lines.csv',
        transformers='outputs/transformers.csv'
    script: "scripts/process_data.py"
