From: Sebastiano Spicuglia <spicuglia.sebastiano@gmail.com>
Subject: Trace synchronization
Date: Sat, 3 Aug 2013 11:44:00 +0200
Message-ID: <CAOSRKdQb3YwEHgasPWx2sHZHCbT5=EqcQSLOAE3ShQUTmqO19Q__25438.0286824473$1375523097$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <spicuglia.sebastiano@gmail.com>) id 1V5YNa-0003ZN-JK
	for lttng-dev@lists.lttng.org; Sat, 03 Aug 2013 05:44:10 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so720084eek.24
	for <lttng-dev@lists.lttng.org>; Sat, 03 Aug 2013 02:44:00 -0700 (PDT)
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

Hello everyone,

I am collecting traces using lttng from different machines.
I saw here http://www.youtube.com/watch?v=YzgRglpXdxQ
(around 24:06) that it is possible to trace with more details
the network subsystem and then synchronise different traces.

Even the eclipse page says something about this
("Integration of trace synchronization")
http://www.eclipse.org/linuxtools/projectPages/lttng/

I read the man of lttng and I look around in the eclipse
plugin but I didn't find anything about this two features
(extended network instrumentation and traces sychnronization).

Is the synchronization somehow performed automatically
by the eclipse plugin and there is no need to enable the extended
instrumentation of the network subsystem?

I have the impression that in the eclipse plugin the term
"synchronization" is related to the the different sources of
events on the same machine, am I right?

Could you please me provide some resources where I can find
more information about the synhcronization of traces coming
from different machines?

Thank you in advance for your help
Regards
Sebastiano
