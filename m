From: Carlos de Sa <desa.carlos@gmail.com>
Subject: Trace files not getting generated
Date: Mon, 10 Sep 2012 12:12:32 +0530
Message-ID: <CAOvs79-D41oE5n+zhQ-Xgc+_zpriKTJNjbYdLq3_-MTic0jJ4A__3574.75222922421$1347259388$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <desa.carlos@gmail.com>) id 1TAxhe-0002PT-IO
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 02:42:38 -0400
Received: by vcbfl11 with SMTP id fl11so1182481vcb.35
	for <lttng-dev@lists.lttng.org>; Sun, 09 Sep 2012 23:42:32 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I've been trying to get kernel tracing working on a TI AM355X EVM
using the standard arago 05.05 toolchain, kernel & ti-sdk filesystem;
but seem to have some buffer issues. Any help on this would be much
appreciated.

After starting a trace session I ran a few programs - the graphics
package apps and standard demo apps. After stopping all seems to be
fine but when I destroy the session it generates a warning. And the
session dir (session2-20120727-122650) is empty as can be seen below -

root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng enable-event sched
_switch,sched_wakeup -k
kernel event sched_switch created in channel channel0
kernel event sched_wakeup created in channel channel0
root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng add-context -k -e
sched_switch -t pid
kernel context pid added to event sched_switch
root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng start
Tracing started for session session2
root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng stop
Tracing stopped for session session2
root@am335x-evm:~/lttng-traces# ls
session1-20120727-122409  session2-20120727-122650
root@am335x-evm:~/lttng-traces# ls session2-20120727-122650/kernel/
root@am335x-evm:~/lttng-traces# ls session2-20120727-122650/kernel/
root@am335x-evm:~/lttng-traces# arm-arago-linux-gnueabi-lttng destroy
[ 1049.263275] ring buffer relay-discard, cpu 0: records were lost. Caused by:
[ 1049.263275]   [ 21949 buffer full, 0 nest buffer wrap-around, 0
event too big ]
Session session2 destroyed at /home/root
root@am335x-evm:~# ls lttng-traces/session2-20120727-122650/kernel/
root@am335x-evm:~# ls lttng-traces/session2-20120727-122650/

Any idea whats going wrong? Fyi I also have debugfs enabled and
mounted. And sessiond when run with -vvv option does not show any
errors.

Previously when enabling all traces (enable-event -a -k) I got the
error at "LTTng: Failure to write metadata to buffers (timeout)" when
starting. I thought this may have been a kernel buffer issue due to
enabling all possible events. But the above log does not show the same
issue so thought this case of only a few events should have worked.

Regards,
Carlos
