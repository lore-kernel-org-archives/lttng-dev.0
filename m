From: =?UTF-8?B?6ZmI5b+X5paH?= <zwchen@aimlab.org>
Subject: A strange problem encountered using urcu-based hash
	table
Date: Fri, 18 Dec 2015 18:02:20 +0800
Message-ID: <CAN0x0o0AEp=jMF1HD1sunGegTc9D-76x5hGVMf+8CLvoxmNiaw__22970.3203346164$1450465079$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1250754531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zwchen@aimlab.org>) id 1a9rrm-00034a-DC
 for lttng-dev@lists.lttng.org; Fri, 18 Dec 2015 05:02:29 -0500
Received: by mail-lb0-f178.google.com with SMTP id u9so60207891lbp.2
 for <lttng-dev@lists.lttng.org>; Fri, 18 Dec 2015 02:02:26 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1250754531==
Content-Type: multipart/alternative; boundary=001a1132fc5c2f3cb60527293c61

--001a1132fc5c2f3cb60527293c61
Content-Type: text/plain; charset=UTF-8

Hi, I'm a Ph.D from Hunan University of China. Recently, our group are
tending to analysis concurrent hash tables using different synchronization
mechanisms, urcu-based hashing is one of our targets. Today, we running an
urcu-based hash table with only ten percent update operations. We found its
CPU utilization is only 3% (while in a read-only workload, the CPU
utilization is 50%). Is there any writer performance limits for urcu? Or
why this happened in your eye?

There is our platform information: Intel SandyBridge EP with 2 sockets,
each sockets with 8 cores and 2 physical threads for each core. OS: Ubuntu
14.04 LTS.
Experimental configuration: 16 threads, ten percent of update operations
and 1 million initial elements in hash table.

We are looking forward for your reply.

Thanks!

-- 
aimlab zwchen

--001a1132fc5c2f3cb60527293c61
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, I&#39;m a Ph.D from Hunan University of China. Recentl=
y, our group are tending to analysis concurrent hash tables using different=
 synchronization mechanisms, urcu-based hashing is one of our targets. Toda=
y, we running an urcu-based hash table with only ten percent update operati=
ons. We found its CPU utilization is only 3% (while in a read-only workload=
, the CPU utilization is 50%). Is there any writer performance limits for u=
rcu? Or why this happened in your eye?<div><br></div><div>There is our plat=
form information: Intel SandyBridge EP with 2 sockets, each sockets with 8 =
cores and 2 physical threads for each core. OS: Ubuntu 14.04 LTS.</div><div=
>Experimental configuration: 16 threads, ten percent of update operations a=
nd 1 million initial elements in hash table.</div><div><br></div><div>We ar=
e looking forward for your reply.</div><div><br></div><div>Thanks!=C2=A0<br=
 clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature"><div di=
r=3D"ltr">aimlab zwchen</div></div>
</div></div>

--001a1132fc5c2f3cb60527293c61--


--===============1250754531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1250754531==--
