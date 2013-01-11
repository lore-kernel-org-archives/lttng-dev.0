From: Aaron Spear <aspear@vmware.com>
Subject: Re: Issues running ust 2.1.0 as non root user
Date: Fri, 11 Jan 2013 09:22:05 -0800 (PST)
Message-ID: <662246047.6161088.1357924924963.JavaMail.root__35050.6242517897$1357924979$gmane$org@vmware.com>
References: <50F04192.3080707@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <aspear@vmware.com>) id 1TtiJ2-000107-Rj
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 12:22:13 -0500
In-Reply-To: <50F04192.3080707@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

----- Original Message -----
> From: "David Goulet" <dgoulet@efficios.com>

> Hi Aaron,
> 
> You will have to provide the verbose logs of the session daemon. So,
> quite simple, start in an other console the session daemon with your
> user like so:
> 
> $ lttng-sessiond -vvv --verbose-consumer > /tmp/sessiond.log
> 
> And do the "lttng" commands again. It's going to be quite easier to
> identify the problem.
> 
> A Fatal error of the session daemon, I suspect something is not right
> with the installation or you are missing memory which I doubt :).
> 
> Thanks!
> David

Thanks very much for the tip, it led me to the solution and it works now.  It would appear that the issue was that there was already some daemon running on the port perhaps in some zombie state or something. I guess maybe they were left there from some earlier failed attempt or something.  I killed these processes and started it up all over and it worked.

I guess the moral of the story is that if this happens at all with some frequency perhaps a little better error message from lttng enable-event would be nice...

here is the error message that I saw when I manually tried to start the sessiond like you instructed:
$ lttng-sessiond -vvv --verbose-consumer > /tmp/sessiond.log
DEBUG3: Creating LTTng run directory: /home/aspear/.lttng [in create_lttng_rundir() at main.c:3692]
DEBUG1: Client socket path /home/aspear/.lttng/client-lttng-sessiond [in main() at main.c:3995]
DEBUG1: Application socket path /home/aspear/.lttng/apps-lttng-sessiond [in main() at main.c:3996]
DEBUG1: LTTng run directory path: /home/aspear/.lttng [in main() at main.c:3997]
DEBUG2: UST consumer 32 bits err path: /home/aspear/.lttng/ustconsumerd32/error [in main() at main.c:4006]
DEBUG2: UST consumer 32 bits cmd path: /home/aspear/.lttng/ustconsumerd32/command [in main() at main.c:4008]
DEBUG2: UST consumer 64 bits err path: /home/aspear/.lttng/ustconsumerd64/error [in main() at main.c:4017]
DEBUG2: UST consumer 64 bits cmd path: /home/aspear/.lttng/ustconsumerd64/command [in main() at main.c:4019]
Error: Already running daemon.

and then this is what I saw when I tried to figure out what daemon was already running:
root@aspear-deb64 ~/lttng-traces
# ps -A | grep ltt
 5024 pts/1    00:00:00 lttng-sessiond
 5110 pts/1    00:00:07 lttng-consumerd
20660 pts/1    00:00:00 lttng-consumerd
25600 ?        00:00:32 lttng-sessiond
25611 ?        00:00:00 lttng-consumerd

thanks again,
Aaron
