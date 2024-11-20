#!/bin/bash

bash mobilenetv2_2.sh "no_ls" 0.0 0 0 0
#bash resnet50.sh "no_ls" 0.0 0 0 0

bash mobilenetv2_2.sh "ls" 0.1 0 0 0

bash mobilenetv2_2.sh "max_sup" 0.0 1 0 0

bash mobilenetv2_2.sh "logit_penatly" 0.0 0 0 1