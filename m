From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: error in generation of trace files
Date: Thu, 27 Feb 2014 15:37:02 -0500
Message-ID: <1393533422.530fa1ee38bd7__45014.868831686$1393533488$gmane$org@www.imp.polymtl.ca>
References: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1WJ7hY-0001SG-Q7
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 15:37:10 -0500
In-Reply-To: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mariya Rampurawala <mariya.r26@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

>  I'm new to lttng. I use ubuntu 13.10. While performing basic operations,
> on command lttng view, i get the following error.
> [error] Cannot open any trace for reading.
>
> [error] opening trace "/home/mariya/lttng-traces/mysession-20140227-163353"
> for reading.
>
> [error] none of the specified trace paths could be opened.

Have a look at the directory and see if trace events have actually been written
or not. You should see something like
/home/mariya/lttng-traces/mysession-20140227-163353/kernel/metadata (if it was
a kernel tracing session)

> the o/p of the command "lttng-sessiond --verbose" is as follows
>
> DEBUG3: Creating LTTng run directory: /home/mariya/.lttng [in
> create_lttng_rundir() at main.c:3692]
> DEBUG1: Client socket path /home/mariya/.lttng/client-lttng-sessiond [in
> main() at main.c:3995]
> DEBUG1: Application socket path /home/mariya/.lttng/apps-lttng-sessiond [in
> main() at main.c:3996]
> DEBUG1: LTTng run directory path: /home/mariya/.lttng [in main() at
> main.c:3997]
> Error: Already running daemon.

You probably did this again while the previous instance of lttng-sessiond was
already running and hence the last error. Kill currently running sessiond and
then start afresh using the verbose mode. Then proceed with usual lttng
commands and observe the debug output (more lines of debug output would be
definitely better). Please show it on the list if you need help in that.

I would also recommend you to have a look at the lttng manual as well as at the
Quickstart doc at [1] for detailed info of what the commands are doing.

[1] https://bugs.lttng.org/projects/lttng-tools/wiki

--
Suchakra
