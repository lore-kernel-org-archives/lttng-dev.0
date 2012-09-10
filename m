From: David Goulet <dgoulet@efficios.com>
Subject: Re: Trace files not getting generated
Date: Mon, 10 Sep 2012 11:12:29 -0400
Message-ID: <504E035D.9050906__19769.6516094313$1347289974$gmane$org@efficios.com>
References: <CAOvs79-D41oE5n+zhQ-Xgc+_zpriKTJNjbYdLq3_-MTic0jJ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TB5f6-0006hx-FJ
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 11:12:32 -0400
In-Reply-To: <CAOvs79-D41oE5n+zhQ-Xgc+_zpriKTJNjbYdLq3_-MTic0jJ4A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Carlos de Sa <desa.carlos@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Carlos,

One thing you could do is to make sure the lttng-consumerd is
installed and accessible by the session daemon. You'll see that in the
lttng-sessiond -vvv logs during the session creation.

It would help us a lot if you could send us the full session daemon
debug output using "-vvv --verbose-consumer".

Could you use the LTTng bug tracker for that so we have a reference in
the future and help us track the issue overtime.

https://bugs.lttng.org

Thanks a lot!
David

Carlos de Sa:
> Hi,
> 
> I've been trying to get kernel tracing working on a TI AM355X EVM 
> using the standard arago 05.05 toolchain, kernel & ti-sdk
> filesystem; but seem to have some buffer issues. Any help on this
> would be much appreciated.
> 
> After starting a trace session I ran a few programs - the graphics 
> package apps and standard demo apps. After stopping all seems to
> be fine but when I destroy the session it generates a warning. And
> the session dir (session2-20120727-122650) is empty as can be seen
> below -
> 
> root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng
> enable-event sched _switch,sched_wakeup -k kernel event
> sched_switch created in channel channel0 kernel event sched_wakeup
> created in channel channel0 root@am335x-evm:~/lttng-traces#
> arm-arago-linux-gnueabi-lttng add-context -k -e sched_switch -t
> pid kernel context pid added to event sched_switch 
> root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng
> start Tracing started for session session2 
> root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng stop 
> Tracing stopped for session session2 
> root@am335x-evm:~/lttng-traces# ls session1-20120727-122409
> session2-20120727-122650 root@am335x-evm:~/lttng-traces# ls
> session2-20120727-122650/kernel/ root@am335x-evm:~/lttng-traces# ls
> session2-20120727-122650/kernel/ root@am335x-evm:~/lttng-traces#
> arm-arago-linux-gnueabi-lttng destroy [ 1049.263275] ring buffer
> relay-discard, cpu 0: records were lost. Caused by: [ 1049.263275]
> [ 21949 buffer full, 0 nest buffer wrap-around, 0 event too big ] 
> Session session2 destroyed at /home/root root@am335x-evm:~# ls
> lttng-traces/session2-20120727-122650/kernel/ root@am335x-evm:~# ls
> lttng-traces/session2-20120727-122650/
> 
> Any idea whats going wrong? Fyi I also have debugfs enabled and 
> mounted. And sessiond when run with -vvv option does not show any 
> errors.
> 
> Previously when enabling all traces (enable-event -a -k) I got the 
> error at "LTTng: Failure to write metadata to buffers (timeout)"
> when starting. I thought this may have been a kernel buffer issue
> due to enabling all possible events. But the above log does not
> show the same issue so thought this case of only a few events
> should have worked.
> 
> Regards, Carlos
> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQTgNdAAoJEELoaioR9I029CsIAKiZQTTHd7Sn4p92fXz+2IK4
2nauu0wwkijcB6hwF/rFsajYrjdtlwwe9aIPapZJB8NsJJ5u80YlpzRatYZFgom3
gGuNJG7Ck1K/3jT501YdIJetmRKUWybKLgIuEpeEv/OJ3w1YKwqenOEBPxHP7RYJ
pEd7J18CnPfUR+Br9ctf/2uS8XT3byqc7u5E8c3Bf1QgMuJyeSBgxgr+O0ovhZkq
StuDt1sV+1F5VOhWYuzJ70LmCNrkjSQzwDNzenYlb+Pko3C9/Mq4AMGo9fczwIkz
n0slfFEX7rCNeeGOszgqwmLBE7k3m94Om5G7CCAfX2j/0X8OnZRhxNHUSeVmpJk=
=7zT5
-----END PGP SIGNATURE-----
