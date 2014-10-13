From: Anand Neeli <anand.neeli@gmail.com>
Subject: avoid ust_libc traces
Date: Tue, 14 Oct 2014 04:26:30 +0530
Message-ID: <CAM5kDqz6mquTQJ-rOx55dn_SHd0QuE1ozndfZ81UCtQSZH+R-g__28391.9188347229$1413241040$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1882785963=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XdoXc-0006J0-S9
 for lttng-dev@lists.lttng.org; Mon, 13 Oct 2014 18:56:39 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so9545491wgg.1
 for <lttng-dev@lists.lttng.org>; Mon, 13 Oct 2014 15:56:31 -0700 (PDT)
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

--===============1882785963==
Content-Type: multipart/alternative; boundary=f46d04426e523ec6d4050555cf8d

--f46d04426e523ec6d4050555cf8d
Content-Type: text/plain; charset=UTF-8

Hi All

I see that  ust_libc:malloc, ust_libc:free, ust_libc:calloc tracepoints
appear a lot in my traces.
I think these appear when  malloc/calloc/free is done in my app.
Is there a way to disable them from logging?

Thanks,
Anand Neeli

--f46d04426e523ec6d4050555cf8d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All<div><br></div><div>I see that =C2=A0ust_libc:malloc=
, ust_libc:free, ust_libc:calloc tracepoints appear a lot in my traces.</di=
v><div>I think these appear when =C2=A0malloc/calloc/free is done in my app=
.</div><div>Is there a way to disable them from logging?</div><div><br></di=
v><div>Thanks,</div><div>Anand Neeli</div><div><br></div></div>

--f46d04426e523ec6d4050555cf8d--


--===============1882785963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1882785963==--
