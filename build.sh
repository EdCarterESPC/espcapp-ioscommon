#!/bin/bash

pod install

fastlane scan --workspace XDUICommon.xcworkspace \
			  --scheme XDUICommon \
			  --derived_data_path build \
			  --output_directory test_output \
			  --slack_only_on_failure false \
			  --code_coverage true