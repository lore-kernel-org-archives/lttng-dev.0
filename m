From: Anand Neeli <anand.neeli@gmail.com>
Subject: Error opening shm /lttng-ust-wait-5-32553
Date: Fri, 17 Apr 2015 10:37:13 +0530
Message-ID: <CAM5kDqytQ2U5W9S-_b7-x4Rjwp7BwwfE594MqubsTF-d_wxzZg__20121.2794207551$1429247287$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1510554072=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YiyUo-0002xX-Kp
 for lttng-dev@lists.lttng.org; Fri, 17 Apr 2015 01:07:19 -0400
Received: by wizk4 with SMTP id k4so8202720wiz.1
 for <lttng-dev@lists.lttng.org>; Thu, 16 Apr 2015 22:07:13 -0700 (PDT)
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

--===============1510554072==
Content-Type: multipart/alternative; boundary=f46d0435c0189f69710513e48df2

--f46d0435c0189f69710513e48df2
Content-Type: text/plain; charset=UTF-8

Hi All,
Can anyone pls tell me in what condition do we get below error?
i'm getting this during compilation, is there a way to avoid it?

libust[26500/26503]: Error: Error opening shm /lttng-ust-wait-5-32553 (in
get_wait_shm() at lttng-ust-comm.c:919)


Thanks,
Anand Neeli

--f46d0435c0189f69710513e48df2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>Can anyone pls tell me in what condition do we=
 get below error?</div><div>i&#39;m getting this during compilation, is the=
re a way to avoid it?</div><div><br></div><div><div>libust[26500/26503]: Er=
ror: Error opening shm /lttng-ust-wait-5-32553 (in get_wait_shm() at lttng-=
ust-comm.c:919)</div></div><div><br></div><div><br></div><div>Thanks,</div>=
<div>Anand Neeli</div></div>

--f46d0435c0189f69710513e48df2--


--===============1510554072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1510554072==--
