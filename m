From: Loris Degioanni <loris@degio.org>
Subject: Announcing sysdig: a new take on system instrumentation
Date: Thu, 03 Apr 2014 10:33:13 -0700
Message-ID: <533D9B59.4050700__48784.5620875762$1396546553$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <loris@degio.org>) id 1WVlVz-0002ES-AG
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 13:33:28 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so2093503pde.39
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 10:33:17 -0700 (PDT)
Received: from [192.168.1.222]
 (108-69-250-205.lightspeed.frokca.sbcglobal.net. [108.69.250.205])
 by mx.google.com with ESMTPSA id xk1sm28083695pac.21.2014.04.03.10.33.14
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 03 Apr 2014 10:33:16 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I=92d like to announce sysdig, a new open source project that I believe =

could be interesting to the LTTng community. Sysdig is designed to offer =

a novel, Wireshark-like approach to system tracing.

http://www.sysdig.org/
https://github.com/draios/sysdig

Sysdig is similar to lttng from the instrumentation point of view, but =

is like a mix between tcpdump, strace and lsof. It adds a set of layers =

on top of traditional kernel-level instrumentation to reconstruct state, =

decode and filter information.

It comes packed with a set of pretty cool features: the ability to =

create system trace files in the wireshark-compatible pcap-ng format, an =

easy to use filtering language, scripting in Lua, and a libpcap-like =

capture library that can be used to build new tools on top of the =

capture infrastructure.

I=92d love to hear what you all think. And, if you do enjoy using sysdig, =

we could really use your help spreading the word.

Thanks!
