From: David Goulet <dgoulet@ev0ke.net>
Subject: UST improvement ideas
Date: Tue, 25 Nov 2014 14:04:04 -0500
Message-ID: <20141125190404.GG6628__42173.2030263685$1416942298$gmane$org@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0790068062=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@ev0ke.net>) id 1XtLPG-0003in-S2
 for lttng-dev@lists.lttng.org; Tue, 25 Nov 2014 14:04:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 243FA89F5B
 for <lttng-dev@lists.lttng.org>; Tue, 25 Nov 2014 19:04:39 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id HAniX41NqBRE for <lttng-dev@lists.lttng.org>;
 Tue, 25 Nov 2014 19:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp.ini-tech.com (Postfix) with ESMTP id 7B0FA8A000
 for <lttng-dev@lists.lttng.org>; Tue, 25 Nov 2014 19:04:38 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
 by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id hezV4Uw2R1AG for <lttng-dev@lists.lttng.org>;
 Tue, 25 Nov 2014 19:04:38 +0000 (UTC)
Received: from thessa (unknown [96.127.212.51])
 by smtp.ini-tech.com (Postfix) with ESMTPSA id 50EC189F5B
 for <lttng-dev@lists.lttng.org>; Tue, 25 Nov 2014 19:04:38 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0790068062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello LTTng!

Yes, I'm not involved in development anymore BUT that does not mean I'm
not using LTTng :).

Let me share with all of you some improvement ideas for LTTng-UST after
using it a bit more extensively in a large application. In a nutshell,
we use LTTng to do measurements of certain subsystem of the application
to come up with a performance baseline. With this, we can notice
regressions and also measure improvements. We also use it to identify
unexpected behaviors for some use cases of which we know the expected
behavior.

Here it is:

1) Having a way to use counters in the trace.

So basically, lots of our measurements are based on timing things which
tracepoints are really useful for that but we also gather stuff like
"How many elements seen of an object in the past hour?". It's doable
with tracepoint but when the number goes up to millions quickly, it does
not really scale to have a million tp for one single counter.

The rough idea is this:

	[...]
	tracepoint_counter_inc(mycomponent, mycounter, n);
	[...]

where "n" is the amount to increment the counter designated by
mycomponent:mycounter.

When the buffers are flushed or/and the tracing stop, this counter could
simply be updated in the trace and, for instance, babeltrace could print
them at the beginning of the output.

Also, inspired by Julien Desfossez latency tracker,
https://github.com/jdesfossez/latency_tracker, having a facility for
that in UST would be amazing. A way to say "ok call this TP if this
value reaches X" would be extremely useful. Basically, an easy way to do
sampling in user space with LTTng. For multithreaded application, it
seems to me that it makes sense to use the awesomness of UST thread
safety to gather counters.

2) By default, adding the PID context is really a must I think for
usability. As soon as we have two different PID with the same procname,
the trace is useless without that PID attached to the event.

3) I really think liblttng-ust-fork should be used by default somehow in
lttng-ust. As soon as the application goes in daemon mode, we lose UST
which seems a bit weird. I understand the mechanics why lttng does that
but still I think it can be hackable to make it by default for
usability.

For instance, with a python launcher that does that, UST will bail out.

	subprocess.Popen(["app", "opt1", "opt2", "--daemon"])


My two cents! I think the above would greatly improve UST usability and
make the user happier. I would be happy to open issue on the tracker if
the above make sense :).

Cheers!
David

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJUdNKkXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02Q9cIAI+r7wYoP2rgTmTzbxbyT4fM
sTGrN2SxaNYqus0sajYMSUP+G5gMD8dsJugrfwDlEH3msYb/tH+cx6edOb61/3ta
N9HL4y+cse39gOyEbfUsMyA8IEA9YDOhT6/usU9AT0kG+nEhTH5ZG+yAumoT5AX8
Xvluizn9AbQD2y1UqLhTVLXGRxZzO38yrNDbpJ6JOCiaeEkJ3fwz5z3F1prsRToh
0hYXU+H8R96fgnLUDWemUYTF/Kl1qKva5A/JQzD/g3wpMtr/xz6u6YFsElqluyEX
VpVHjc0LND8BYiNNPqSnxab2vMcY27kXuiPsw3Qy2RLZq4MOstvKAsGFwAm/SNM=
=xa9A
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--


--===============0790068062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0790068062==--
