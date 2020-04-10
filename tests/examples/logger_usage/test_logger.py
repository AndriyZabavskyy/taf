#! /usr/bin/env python
# Copyright (c) 2011 - 2017, Intel Corporation.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""``test_logger.py``

`Logger functionality demo test suite`

Notes:
    HowTo:

    This test module need to connect to some linux host. Update the following configuration files
    with proper ssh credentials::

        $ cat environment.json
        [
        {"name": "Localhost1", "entry_type": "linux_host", "instance_type": "generic", "id": 999,
            "ipaddr": "localhost", "ssh_user": "your_user", "ssh_pass": "your_password",
            "ports": ["lo"]
        }
        ]

        $ cat setup.json
        {
        "env": [
                {"id": 999}
               ],
        "cross": {}
        }

    Now you can launch it::

        $ cd taf/tests
        $ py.test --loglevel=DEBUG --env=path/to/environment.json --setup_file=path/to/setup.json --call_check=fast examples/logger_usage/test_logger.py
        --logdir=path/to/logdir

Notes:
    --logdir is mandatory option to check sshlog functionality. If you don't set logdir only stdout logger will be configured.

"""

from testlib import loggers


class TestSSHLogger(object):
    """This suite demonstrates autolog and sshlog fixtures usage.

    """

    log = loggers.ClassLogger()

    def test_case_one(self):

        self.log.info("I'm in TC one.")
        # For this command output the new file test_case_one_<PID>__id_<lhost id>_type_<lhost type>.log has to be created.

    def test_case_one_two(self):
        # This test function doesn't use env fixture, so ssh logging configuration has to be omitted.
        self.log.info("TC with no env fixture.")

    def test_case_three(self):
        # The same as the first test function, but new file for ssh logs has to be created.
        self.log.info("I'm in TC tree.")