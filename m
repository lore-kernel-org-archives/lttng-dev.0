From: "eikosaedron@gmail.com" <eikosaedron@gmail.com>
Subject: Getting 64bit int from babeltrace library
Date: Thu, 02 Aug 2012 20:56:16 -0700
Message-ID: <138eaa0642b.-2681066139298325110.3245307989283453259__9834.69323623485$1343966777$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0522460182=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eikosaedron@gmail.com>) id 1Sx8zw-0000EK-8b
	for lttng-dev@lists.lttng.org; Thu, 02 Aug 2012 23:56:24 -0400
Received: by ggcs6 with SMTP id s6so397051ggc.35
	for <lttng-dev@lists.lttng.org>; Thu, 02 Aug 2012 20:56:18 -0700 (PDT)
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

--===============0522460182==
Content-Type: multipart/alternative;
	boundary="----=_Part_153765_440578012.1343966176298"

------=_Part_153765_440578012.1343966176298
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Hi all,

I hope you can help me with a problem I've encountered using the babeltrace C libraries to write a trace parsing tool.

I have fields which contain 64 bit integers. However, when I call bt_ctf_get_uint64 from the event callback on that field, it only returns the lower 32 bits. The upper bits are all 0's. I've called get_int_len to confirm they are 64 bits and tried accessing the values directly but I'm still facing the same problem.

Running babeltrace on the same trace files prints out the full 64 bits in base 16. The top 32 bits should not be all 0's.

Could there be something wrong with my build setup or anything else I've overlooked in getting the the full 64 bit integers into the babeltrace structures?

Thanks,
Jon




------=_Part_153765_440578012.1343966176298
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><div style=3D'font-size:10pt;font-family:Verdana,Arial,Helvetica=
,sans-serif;'><br>Hi all,<br><br>I hope you can help me with a problem I've=
 encountered using the babeltrace C libraries to write a trace parsing tool=
.<br><br>I have fields which contain 64 bit integers. However, when I call =
bt_ctf_get_uint64 from the event callback on that field, it only returns th=
e lower 32 bits. The upper bits are all 0's. I've called get_int_len to con=
firm they are 64 bits and tried accessing the values directly but I'm still=
 facing the same problem.<br><br>Running babeltrace on the same trace files=
 prints out the full 64 bits in base 16. The top 32 bits should not be all =
0's.<br><br>Could there be something wrong with my build setup or anything =
else I've overlooked in getting the the full 64 bit integers into the babel=
trace structures?<br><br>Thanks,<br>Jon<br><br><br></div></body></html>
------=_Part_153765_440578012.1343966176298--


--===============0522460182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0522460182==--
