# S3IT call 19th October 2020


## Computing
We will initially use the Science cloud, which has a maximum of 32 cores and 256GB. This should (hopefully) be fine with ImageJ.

Science cloud can be configured to do all analysis steps and it is fully under our control.

It has an initial storage of 100GB including OS.

## Storage

### Attached storage
This is storage which can be mounted in the cloud computing instance and in the UZH network as a normal network drive. This will  ake it possible to upload the raw data and to download Research and Archive Ready Data.

The amount is is allocated, i.e. it has to be set before it can be used, but can easily be changed.

The price is 40CHF / TB / year

### Object storage
Object storage can not be accessed as a network drive, but one has to use a client software to access the data. It comes in two flavours, which differ regarding to time to get the data after a drive failure. Both have two physical copies of the data, but on site (likely next to each other).

The one (replica 2) uses two drives and saves it on both, i.e. if one fails, one can still read from the second one without realising the difference. It is therefore more expensive and costs 25CHF / TB / year. The second one uses a RAID to write the data. This means, that, in case of a drive failure, the failed drive needs to be replaced and be rebuild, which takes up to two days. So no immediate access. But it is cheaper and costs only 15CHF / TB / Year.
I would suggest to use the RAID option as it is cheaper and provides the same redundancy with the price that it will in the worst case only be available after two days.

For both, they offer off-site backup solutions, but they are expensive and I don't think are needed in our case.

### IEU User Server
This is pure network drive and does not cost anything for smaller volumes. Tina confirmed that we can use this one for our SQLite database (Research Ready Data), backups are provided

### Sugested Storage solution 

1. Raw data is created locally and transferred to the **Attached Storage**
2. Raw data is processed via Science Cloud and ARD is stored and RRD is added to SQLite database on **Attached Storage**
3. after processing (end of pipeline) 
	- Raw Data is moved to **Object Storage**
	- ARD is moved to **Object Storage**
	- RRD is copied to **Object Storage**
	- RRD is moved to **IEU User Server**
4. This new RRD SQLite database will be backed up on the **IEU User Server**
5. The data from the new SQLite database will be copied into the normal SQLite database, which will **not** be backed up and is the one which will be accessed for the analysis.

#### By using this strategy, we scan expect the following storage requirements:

- **Attached Storage**: **1TB** as it will be moved after processing
- **Object Storage**:   Increasing to a maximum of **200TB** if we keep the raw data, up to **100TB** if we discard the raw data.
- **IEU User Server**:  Increasing to **5TB** over time

#### Costs per year
- **Attached Storage**: 40 CHF / 1TB / Year == 40CHF per year
- **Object Storage**:   15 CHF / 1TB / Year == up to 20.000CHF per year
- **IEU User Server**:  No additional costs at the moment




