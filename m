From: David Goulet <dgoulet@efficios.com>
Subject: Re: Working with lttng enable-channel
Date: Tue, 25 Jun 2013 10:07:25 -0400
Message-ID: <51C9A41D.9070807__24552.9185784564$1372169290$gmane$org@efficios.com>
References: <CA+f7N8nXaViFf9UKRU9vFttcyjnVqQ38Np56pa1+dj=V7jAvxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UrTu9-0001EY-82
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 10:07:33 -0400
In-Reply-To: <CA+f7N8nXaViFf9UKRU9vFttcyjnVqQ38Np56pa1+dj=V7jAvxA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Avi Goren <avi@reduxio.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

There is indeed something wrong.

Avi Goren:
> Hi,
> I'm using lttng-ust and in the process of the attempt to gain some flush
> frequency control I encountered a problem.
> I'm having difficulties with the use of enable-channel.
> it doesn't seem to apply property changes. here's an example:
> -------------------------------------------------------------------------
> root@ubuntu:~# lttng list
> Currently no available tracing session
> root@ubuntu:~# lttng create ses
> Session ses created.
> Traces will be written in /home/avig/lttng-traces/ses-20130624-163340
> root@ubuntu:~# lttng enable-event -a -u -s ses -c ch
> All UST events are enabled in channel ch

This command creates and enables all event in the channel "ch" with the default
settings for the channel.

> root@ubuntu:~# lttng disable-channel ch -u -s ses
> UST channel ch disabled for session ses
> root@ubuntu:~# lttng enable-channel ch -u --subbuf-size 1024 --num-subbuf 1
> UST channel ch enabled for session ses

This command actually only enable the *already* existing channel. Once a channel
is created, you can't change the attributes, it's immutable.

> root@ubuntu:~# lttng list ses -c ch
> Tracing session ses: [inactive]
>     Trace path: /home/avig/lttng-traces/ses-20130624-163340
> 
> === Domain: UST global ===
> 
> Buffer type: per PID
> 
> - ch: [enabled]
> 
>     Attributes:
>       write mode: discard
>       subbufers size: 4096 bytes
>       number of subbufers: 4
>       switch timer interval: 0 usec
>       read timer interval: 0 usec
>       output: mmap()
> 
>     Events:
>       * (type: tracepoint) [enabled]
> 
> root@ubuntu:~# lttng version 
> lttng version 2.2.0-rc2 - Cuda
> ...
> -------------------------------------------------------------------------
> 
> Am I doing something wrong?
> Is there a way to control flushing policy besides the use of enable-channel?

If you want to control the flushing timing of a channel, use "--switch-timer".
For instance, for a flush buffer at each 200ms:

$ lttng enable-channel ch -u --switch timer 200000

Hope this can help!
David

> Thanks,
> Avi
> 
> 
> This body part will be downloaded on demand.
