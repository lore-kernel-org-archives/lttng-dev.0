From: Lakshmi Anusha <anujntu93@gmail.com>
Subject: Bug #900 : Double free or corruption crash on relay
	daemon
Date: Mon, 3 Aug 2015 11:57:55 +0200
Message-ID: <CABOU80pZHpTFVLYLMrYugnzdRRTUEV9R9vRP3Q44t37Xx+87fg__13026.108677923$1438886078$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1468179579=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anujntu93@gmail.com>) id 1ZMCVN-0006rG-8p
 for lttng-dev@lists.lttng.org; Mon, 03 Aug 2015 05:58:03 -0400
Received: by igbpg9 with SMTP id pg9so52373635igb.0
 for <lttng-dev@lists.lttng.org>; Mon, 03 Aug 2015 02:57:55 -0700 (PDT)
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

--===============1468179579==
Content-Type: multipart/alternative; boundary=089e014940982169ca051c653486

--089e014940982169ca051c653486
Content-Type: text/plain; charset=UTF-8

Hello,

We are using LTTng-tools version 2.6 on our target.

We have observed a crash on relay daemon, when 24 streaming sessions with
same name were created from 24 different targets towards a relay daemon
running on remote host.

From logs, we observed below traces:
*PERROR - 09:24:33.402270 [31294/31310]: Relay index to close fd 32575: Bad
file descriptor (in deferred_free_relay_index() at index.c:41)*
**** Error in `./lttng-relayd': double free or corruption (out):
0x00007f3fdc04d930 ****

Are there any known issues similar to above in relay daemon LTTng-tools
version 2.6?
If yes, kindly let us know.

Bug #900 has been raised for the same.
Thanks in advance.

Best Regards,
Lakshmi Anusha

--089e014940982169ca051c653486
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:12.8000001907349px">Hello,</div><d=
iv style=3D"font-size:12.8000001907349px"><br></div><div style=3D"font-size=
:12.8000001907349px">We are using LTTng-tools version 2.6 on our target.</d=
iv><div style=3D"font-size:12.8000001907349px"><br></div><div style=3D"font=
-size:12.8000001907349px">We have observed a crash on relay daemon, when 24=
 streaming sessions with same name were created from 24 different targets t=
owards a relay daemon running on remote host.</div><div style=3D"font-size:=
12.8000001907349px"><br></div><div style=3D"font-size:12.8000001907349px">F=
rom logs, we observed below traces:</div><div style=3D"font-size:12.8000001=
907349px"><b>PERROR - 09:24:33.402270 [31294/31310]: Relay index to close f=
d 32575: Bad file descriptor (in deferred_free_relay_index() at index.c:41)=
</b></div><div style=3D"font-size:12.8000001907349px"><b>*** Error in `./lt=
tng-relayd&#39;: double free or corruption (out): 0x00007f3fdc04d930 ***</b=
></div><div style=3D"font-size:12.8000001907349px"><br></div><div style=3D"=
font-size:12.8000001907349px">Are there any known issues similar to above i=
n relay daemon LTTng-tools version 2.6?</div><div style=3D"font-size:12.800=
0001907349px">If yes, kindly let us know.</div><div style=3D"font-size:12.8=
000001907349px"><br></div><div style=3D"font-size:12.8000001907349px">Bug #=
900 has been raised for the same.</div><div style=3D"font-size:12.800000190=
7349px">Thanks in advance.</div><div style=3D"font-size:12.8000001907349px"=
><br></div><div style=3D"font-size:12.8000001907349px">Best Regards,</div><=
div style=3D"font-size:12.8000001907349px">Lakshmi Anusha</div></div>

--089e014940982169ca051c653486--


--===============1468179579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1468179579==--
