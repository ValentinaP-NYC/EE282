Update as of Dec. 13th 2024:

- My working directory for the ee282 final project during this semester has been in /pub/valenp/repositories/myfirstproject since there is more memory
- In hindsight I should have made a plan for how I wanted to deal with this when it came time to pushing my work to git from ~/myrepos/ee282/ \
which I have used to turn in class assignments.
- Basically copying the /pub/valenp/repositories/myfirstproject/ straight up will use 368 GB and I only have 45 GB available in ~/myrepos/ee282/

- I hacked the command below to	test how I might copy files that are not memory	intensive and it comes out to 121.8 MB
rsync -av --dry-run --exclude 'data/raw/*' \
--exclude 'data/processed/trinity/*' \
--exclude 'data/processed/trinotate/*' \ 
--exclude 'data/processed/trimmed_out/*' \
--exclude 'data/processed/reference_RSEM_quant_pc/*' \
--exclude 'data/processed/reference_RSEM_quant_xm/*' \
--exclude 'data/processed/rsem_out/*' /pub/valenp1/repositories/myfirstgitproject/ ~/myrepos/ee282/

Update as of Nov. 13th 2024:

- homework3.md and homework3.html are available on GitHub in the ee282/homework3/ branch.

