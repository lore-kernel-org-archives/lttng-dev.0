From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Subject: clarification about the "provider name" argument
Date: Thu, 27 Sep 2012 14:23:35 +0200
Message-ID: <CAPkDDd7zv0+yjtMBSL2KN1CCmX70QiePBOykDNzJ+Rkvb1f2jQ__27078.9138311104$1348748651$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sebastien.barthelemy@gmail.com>) id 1THD81-0000Yo-IP
	for lttng-dev@lists.lttng.org; Thu, 27 Sep 2012 08:23:41 -0400
Received: by pabkp12 with SMTP id kp12so1655346pab.35
	for <lttng-dev@lists.lttng.org>; Thu, 27 Sep 2012 05:23:35 -0700 (PDT)
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

A tracepoint is defined with a declaration like

      TRACEPOINT_EVENT(
            provider_name,
            tracepoint_name,
            TP_ARG(),
            TP_FIELDS())

I wonder what is the meaning and the role of the "provider_name" argument.

In other words, what is the "provider" that we name here?

Is it the instrumented component which will generate (provide?) the events ?
Or is it the probes provider (the library which we LD_PRELOAD when tracing) ?

Note that at some places the provider name argument is also named component_name
or domain (this last is in lttng-gen-tp source code).

A related question is about the constraints on the "provider name"
given in the tracepoints definition file.
For instance, is it legit to have two files which define different
tracepoints with the same provider name, and with two distinct probes
provider libraries

Something like tp0.h:

      TRACEPOINT_EVENT(
            provider_name,
            tracepoint_name0,
            TP_ARG(),
            TP_FIELDS())

and tp1.h:

      TRACEPOINT_EVENT(
            provider_name,
            tracepoint_name1,
            TP_ARG(),
            TP_FIELDS())

Thanks!
