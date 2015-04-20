From: Chidhu R <chid1989@gmail.com>
Subject: Trace to console
Date: Mon, 20 Apr 2015 12:58:03 -0700
Message-ID: <CAL1ZhONFm1+bXP_j4X=kUKnsQFaqTqdVTY-Cc_uY4Ni-Ok-LiQ__41224.9611611061$1429560010$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0143342213=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f52.google.com ([209.85.215.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YkHqD-00046L-NO
 for lttng-dev@lists.lttng.org; Mon, 20 Apr 2015 15:58:54 -0400
Received: by lagv1 with SMTP id v1so135424101lag.3
 for <lttng-dev@lists.lttng.org>; Mon, 20 Apr 2015 12:58:43 -0700 (PDT)
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

--===============0143342213==
Content-Type: multipart/alternative; boundary=001a11c3511070042b05142d5b78

--001a11c3511070042b05142d5b78
Content-Type: text/plain; charset=UTF-8

Hello,

I was looking for a way to trace to console rather than save to disk /
stream. I read about lttng tracef feature. But it does not include the wide
range of benefits brought by tracepoints. So what I want is to use the
tracepoints and trace to console instead. For example, if there are 5
tracepoint events, I want to trace 3 of them to console and let the other
go the disk or whatever. How to achieve this.

Thanks
Chid

--001a11c3511070042b05142d5b78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I was looking for a way to trace=
 to console rather than save to disk / stream. I read about lttng tracef fe=
ature. But it does not include the wide range of benefits brought by tracep=
oints. So what I want is to use the tracepoints and trace to console instea=
d. For example, if there are 5 tracepoint events, I want to trace 3 of them=
 to console and let the other go the disk or whatever. How to achieve this.=
</div><div><br></div><div>Thanks</div><div>Chid</div></div>

--001a11c3511070042b05142d5b78--


--===============0143342213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0143342213==--
