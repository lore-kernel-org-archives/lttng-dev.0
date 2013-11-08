From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Using userspace tracepoints with icc
Date: Thu, 07 Nov 2013 23:50:21 -0500
Message-ID: <527C6D8D.1010103__26914.4013910138$1383886268$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1Vee1c-0004mE-Dd
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 23:50:29 -0500
Received: by mail-ie0-f170.google.com with SMTP id at1so2510194iec.1
	for <lttng-dev@lists.lttng.org>; Thu, 07 Nov 2013 20:50:22 -0800 (PST)
Received: from sparrow.sbird.org (69-165-208-83.cable.teksavvy.com.
	[69.165.208.83])
	by mx.google.com with ESMTPSA id cl4sm2100565igc.1.2013.11.07.20.50.22
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 07 Nov 2013 20:50:22 -0800 (PST)
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

Hello folks,

A few weeks ago, I was working on an application which used icc (the
Intel C Compiler) to compile its sources. I wanted to trace it but
wasn't able to compile with the tracepoints, the ".c" file was spawning
a ": internal error: backend signal" from icc. Still, there is a
workaround to be able to trace.

Using gcc to compile the tracepoints (or using the object file generated
by lttng-gen-tp, which uses gcc) and linking the object file to the
application worked like a charm. It is not the best way as it forces to
use two different compilers, but it still allows to trace.

Just thought I'd share this workaround if someone else search how to use
LTTng-UST with icc.

Rapha=EBl
