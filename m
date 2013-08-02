From: Sebastiano Spicuglia <spicuglia.sebastiano@gmail.com>
Subject: Extendend net
Date: Fri, 2 Aug 2013 12:06:59 +0200
Message-ID: <CAOSRKdQDo-95DDw1_KDkSSgNKRwWyFsmKqWuVErZfNZqpZK2gg__27130.1601468169$1375994945$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <spicuglia.sebastiano@gmail.com>) id 1V5CGH-0002cb-H8
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 06:07:09 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so224521eak.22
	for <lttng-dev@lists.lttng.org>; Fri, 02 Aug 2013 03:06:59 -0700 (PDT)
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
