From: "eikosaedron@gmail.com" <eikosaedron@gmail.com>
Subject: Requesting help running LTTng-UST
Date: Wed, 11 Jul 2012 23:55:40 -0700
Message-ID: <13879f8bb0c.-1471800681871108244.-2125736047563382664__23907.877240754$1342076177$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1341930992=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eikosaedron@gmail.com>) id 1SpDJW-0001rY-Hd
	for lttng-dev@lists.lttng.org; Thu, 12 Jul 2012 02:55:51 -0400
Received: by pbbrq8 with SMTP id rq8so4026175pbb.35
	for <lttng-dev@lists.lttng.org>; Wed, 11 Jul 2012 23:55:44 -0700 (PDT)
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

--===============1341930992==
Content-Type: multipart/alternative;
	boundary="----=_Part_101607_1501331963.1342076140299"

------=_Part_101607_1501331963.1342076140299
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've inherited a project that had LTTng userspace tracing built in in early 2012. I installed the latest LTTng releases from source on my build machine (debian 6 3.4) and built the binaries with LTTng enabled. I'm running them on a test server (sles 11 3.1) with a slightly older version of LTTng installed (current from two months ago).

I have been running the binaries with appropriate input and invoking LTTng without any obvious problems, but have been unable to observe any tracing results. LTTng --verbose flags don't reveal any errors. I have started LTTng based on a sample script that came with the project so I believe it was invoked correctly.

My main question at this point is whether I should consider downgrading my build machine or upgrading the test machine, whether tracing is likely broken in the binaries, or if there is anything else I may have overlooked. I hope someone more experienced with running LTTng can advise me as this is new ground for me.

Thanks,
Jon


------=_Part_101607_1501331963.1342076140299
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><div style=3D'font-size:10pt;font-family:Verdana,Arial,Helvetica=
,sans-serif;'>I've inherited a project that had LTTng userspace tracing bui=
lt in in early 2012. I installed the latest LTTng releases from source on m=
y build machine (debian 6 3.4) and built the binaries with LTTng enabled. I=
'm running them on a test server (sles 11 3.1) with a slightly older versio=
n of LTTng installed (current from two months ago).<br><br>I have been runn=
ing the binaries with appropriate input and invoking LTTng without any obvi=
ous problems, but have been unable to observe any tracing results. LTTng --=
verbose flags don't reveal any errors. I have started LTTng based on a samp=
le script that came with the project so I believe it was invoked correctly.=
<br><br>My main question at this point is whether I should consider downgra=
ding my build machine or upgrading the test machine, whether tracing is lik=
ely broken in the binaries, or if there is anything else I may have overloo=
ked. I hope someone more experienced with running LTTng can advise me as th=
is is new ground for me.<br><br>Thanks,<br>Jon<br></div></body></html>
------=_Part_101607_1501331963.1342076140299--


--===============1341930992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1341930992==--
