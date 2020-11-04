1. Everything above line 100 is incorporated, and that is what I compared and what is identical - is this correct? (parameter have to be set later)  

	**U:** Yes. That's the video analysis part in the workflow that I uploaded. Note however that e.g. the threshold adjustment part is not necessary in the pipeline.
	
2. All steps are done per trajectory - correct? that means, that one huge Master.rd file could be analysed in the same way?

	**U:** Theoretically yes, if I understood you correctly that is (the output of Bemovi is trajectory.data stored in Master.RData and the "Process Data" part is all based on that table). Note however that the "Process Data" depends at multiple steps on the magnification used (again, see the workflow that I uploaded and also the comments from yesterday regarding it). Merging the two trajectory.data of one day (is that what you meant by one big Master.Rdata?) before processing them is thus not necessarily better. Also, I was under the impression that we want to analyze the data from the single sampling day separately (in case you meant that)... see also answer under 5.
	
3. How does the analysis scale - i.e. linear with the number of trajectories?

	**U:** If you meant the time required with increasing number of rows in trajectory.data, then I do not know, sorry.
	
4. Where is what saved to which file (after line 100)? Is the Master.rd file above line 100 changed below?

	**U:** I just saw that I left out a part. I will update the script here on teams. Anyway, here is the thing:
	
	The overlay function of Bemovi unfortunately always uses the trajectory.data stored in Master.Rdata in the folder "5 - merged data/". This is not good because in that folder is the unfiltered trajectory.data (the bemovi output), but we want to do the overlays based on the filtered ones.
	
	The script (including the part that was partially missing) does the following:
	
	1. it creates a new folder "6 - merged data unfiltered/" and saves the unfiltered trajectory.data in it.
	2. After the "Data Processing" part it saves the filtered trajectory.data in the folder "5 - merged data" as the file Master.Rdata (overwriting the unfiltered one!). 
	3. The script also saves the morph_mvt as Morph_mvt.RData. This is in the section "Update: save the new filtered..." in the script (line ca. 181). 
	4. What is missing is that the mean_density_per_ml table should also be saved. But the creation of that table is anyway not ready yet...
		
5. Considering required time for the analysis / likelihood of changing the parameter for the filter, ... would it make sense to run the analysis as a step after the pipeline?

	**U:** If by that you mean that we only process the data once the videos from the whole experiment are analysed (which is what I understood as "a step after the pipeline") then I don't think that was Owen's plan... AFAIK the processing of the data from the video analysis should be part of the pipeline... but maybe ask Owen.
	
6. Doesn't line 165 overwrite the results `"Morph_mvt.RData"` from line 149?

	**U:** Yes it does and it is supposed to. See workflow (filtering based on size)