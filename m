From: Thierry Bultel <thierry.bultel@wanadoo.fr>
Subject: "lttng enable-event" fails
Date: Tue, 24 Jun 2014 08:47:21 +0200
Message-ID: <53A91EF9.1050006__2728.70614794574$1403592521$gmane$org@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]
 helo=smtp.smtpout.orange.fr) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thierry.bultel@wanadoo.fr>) id 1WzKVx-00042p-Fv
 for lttng-dev@lists.lttng.org; Tue, 24 Jun 2014 02:47:39 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I am using lttng (2.4.1), target is ARM Cortex A9; compiler is 
gcc-4.7.3, but I have the same issue with gcc-4.8.2
The kernel is Freescale's 3.0.35-4.1.0


lttng fails to start:

[root@buildroot ~]# lttng create
Session auto-19700319-135920 created.
Traces will be written in /root/lttng-traces/auto-19700319-135920
[root@buildroot~]# lttng enable-event --kernel --all
PERROR [5831/5915]: wait: Success (in run_as_clone() at runas.c:243)
Error: Trace directory creation error
Error: Events: Kernel create session failed (channel channel0, session
auto-19700319-135920)

My analysis show that lttng attempts to create the trace directory, when
"lttng enable-event" is called.
To do so, it uses a slave thread that performs a kind of "mkdir -p" ,
that thread is spawned via a call to "clone"
and the father waits for it via "waitpid".

When the slave returns, waitpid says it is not completed. Added a little
code to shows that the thread
is killed with SIGSEGV at the time it calls "return"

Changing it to call "exit" instead, makes it a little better, but other
numerous errors come when
calling "lttng start"

Did anyone encounter such an issue ?

Best regards
Thierry Bultel
