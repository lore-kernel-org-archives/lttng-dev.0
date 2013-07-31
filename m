From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Names collisions with LTTng-UST
Date: Wed, 31 Jul 2013 14:29:12 -0400
Message-ID: <CAFXXi0kt1KfRfEPm4T-NqPqEsKQO0n96P2df4Ds6TyJBJPh26Q__45813.4731081829$1375295467$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1V4b9h-0003qi-M1
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 14:29:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so2039932obb.33
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 11:29:44 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello tracing bending units,

I encountered a problem while trying to put UST tracepoints in GDB
today. Since GDB defines a struct tracepoint, it conflicts with
LTTng's struct tracepoint. Renaming all struct tracepoint in UST to
struct ust_tracepoint, and rebuilding/installing, provided a simple
workaround. Would it be possible to do change something in LTTng to
avoid conflicts like this in the future?

Thanks

Simon
