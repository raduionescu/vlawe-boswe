# Code for VLAWE and BOSWE
Code for computing VLAWE [Ionescu et al., NAACL 2019] and BOSWE [Butnaru et al., KES 2017] representations.

### 1. License agreement

Copyright (C) 2019  Radu Tudor Ionescu, Andrei M. Butnaru
 
 This package contains free software: you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free Software
 Foundation, either version 3 of the License, or any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY
 WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this
 program (see COPYING.txt package file). If not, see <http://www.gnu.org/licenses/>.
 
### 2. Citation

Please cite the corresponding works [1,2] if you use this software (or a modified version of it) in any scientific
 work:
 
[1] Radu Tudor Ionescu, Andrei M. Butnaru. Vector of Locally-Aggregated Word Embeddings (VLAWE): A Novel Document-level Representation. In Proceedings of NAACL, 2019.

[2] Andrei M. Butnaru, Radu Tudor Ionescu. From Image to Text Classification: A Novel Approach based on Clustering Word Embeddings. In Proceedings of KES, 2017.

Bibtex:
```
@inproceedings{ Ionescu-NAACL-2019,
	author = {{Radu Tudor} Ionescu and Andrei Butnaru},
	title = "{Vector of Locally-Aggregated Word Embeddings (VLAWE): A Novel Document-level Representation}",
	booktitle = {Proceedings of NAACL},
	year = {2019},
}

@inproceedings{ Butnaru-KES-2017,
	author = {Andrei Butnaru and {Radu Tudor} Ionescu},
	title = "{From Image to Text Classification: A Novel Approach based on Clustering Word Embeddings}",
	booktitle = {Proceedings of KES},
	year = {2017},
	pages = {1784--1793},
}
```

### 3. Usage

This MATLAB code can be used to reproduce the results from the works [1,2] from above. Before running the code, you need to install the following dependencies:
- VLFeat: http://www.vlfeat.org (place the library in the "code/vlfeat" subfolder)
- PQ Kernel: http://pq-kernel.herokuapp.com (place files directly in the "code" subfolder)
- LibSVM: https://www.csie.ntu.edu.tw/~cjlin/libsvm/ (after installation, add the corresponding path so that the functions ```svmtrain``` and ```svmpredict``` become available from everywhere in MATLAB)
- GloVe: https://nlp.stanford.edu/projects/glove/ (can be installed and used independently)

After installing the above frameworks, proceed as following:
1. Extract the GloVe word vectors from each text document and save the results in the "code/data" subfolder. The output for each text document should be written in a different .txt file. The output file should contain comma separated values with one word vector per line.
2. Run the following script in MATLAB:
```
>> runAll
```

### 4. Feedback and suggestions
 
Send an e-mail to: raducu[dot]ionescu{at}gmail[dot].com
