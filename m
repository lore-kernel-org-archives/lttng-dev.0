From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH 1/5] run-report: Use libtool wrapper to
 spawn the sessiond for tests
Date: Tue, 18 Dec 2012 16:43:53 -0500
Message-ID: <50D0E399.8060804__39326.6084990048$1355867077$gmane$org@efficios.com>
References: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Tl4xA-0005T7-Ay
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 16:43:56 -0500
In-Reply-To: <1355866278-11702-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks!

David

Christian Babeux:
> The run-report script was using the sessiond binary generated via libtool
> under the ".libs/" folder. When using this binary, the consumerd used when
> starting the sessiond is the one installed system-wide (if any). This could
> lead to tests failures if no consumer are installed in the system or any
> version mismatch occurs.
> 
> This commit fix this by using the consumerd that was built with libtool in
> the local source tree.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/run-report.py | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/run-report.py b/tests/run-report.py
> index 1516c7e..ca6e6a3 100755
> --- a/tests/run-report.py
> +++ b/tests/run-report.py
> @@ -5,11 +5,14 @@ import subprocess
>  import threading
>  import Queue
>  import time
> +import shlex
>  
>  from signal import signal, SIGTERM, SIGINT
>  
>  SESSIOND_BIN_NAME = "lttng-sessiond"
> -SESSIOND_BIN_PATH = "src/bin/lttng-sessiond/.libs/"
> +SESSIOND_BIN_PATH = "src/bin/lttng-sessiond/"
> +CONSUMERD_BIN_NAME = "lttng-consumerd"
> +CONSUMERD_BIN_PATH = "src/bin/lttng-consumerd/"
>  TESTDIR_PATH = ""
>  
>  PRINT_BRACKET = "\033[1;34m[\033[1;33m+\033[1;34m]\033[00m"
> @@ -208,19 +211,26 @@ def spawn_session_daemon():
>          os.kill(pid, SIGTERM)
>  
>      bin_path = os.path.join(TESTDIR_PATH, "..", SESSIOND_BIN_PATH, SESSIOND_BIN_NAME)
> +    consumer_path = os.path.join(TESTDIR_PATH, "..", CONSUMERD_BIN_PATH, CONSUMERD_BIN_NAME)
>  
>      if not os.path.isfile(bin_path):
>          print "Error: No session daemon binary found. Compiled?"
>          return 0
>  
>      try:
> -        sdaemon_proc = subprocess.Popen([bin_path, "-d"], shell=False,
> -                stderr = subprocess.PIPE)
> +        args = shlex.split("libtool execute " + bin_path
> +                           + " --consumerd32-path=" + consumer_path
> +                           + " --consumerd64-path=" + consumer_path)
> +
> +        sdaemon_proc = subprocess.Popen(args, shell = False, stderr = subprocess.PIPE)
> +
>      except OSError, e:
>          print e
>          return 0
>  
> -    return get_pid(SESSIOND_BIN_NAME)
> +    time.sleep(1)
> +
> +    return get_pid("lt-" + SESSIOND_BIN_NAME)
>  
>  def start_test(name):
>      """
