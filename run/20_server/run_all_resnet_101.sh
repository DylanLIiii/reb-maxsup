#!/bin/bash

#bash resnet101.sh "no_ls" 0.0 0 0 0
#bash resnet50.sh "no_ls" 0.0 0 0 0

#bash resnet101.sh "ls" 0.1 0 0 0

bash resnet101.sh "max_sup" 0.0 1 0 0

bash resnet101.sh "logit_penatly" 0.0 0 0 1