From: shirish gajera <gajerashirish@gmail.com>
Subject: Return value by LTTng command
Date: Sun, 5 Apr 2015 15:20:01 -0700
Message-ID: <CAG77vrrVh5o9cdeyYKuwU3GsfsP0sWwwBVAOo7EZJ2eJmU603w__29453.2169973992$1428272469$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0247267945=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gajerashirish@gmail.com>) id 1Yesti-0002wn-Vt
 for lttng-dev@lists.lttng.org; Sun, 05 Apr 2015 18:20:12 -0400
Received: by wgin8 with SMTP id n8so14480772wgi.0
 for <lttng-dev@lists.lttng.org>; Sun, 05 Apr 2015 15:20:01 -0700 (PDT)
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

--===============0247267945==
Content-Type: multipart/alternative; boundary=f46d0438901520adaf051301958c

--f46d0438901520adaf051301958c
Content-Type: text/plain; charset=UTF-8

Hi,

I am looking for the return value by LTTng command, but I don't see this
information in man page.

For example return value of the following command.
lttng create --snapshot Testing
lttng enable-channel --userspace --tracefile-size 1M --tracefile-count 1
--overwrite channel1
lttng enable-event -u -a -c channel1
lttng start

Can anyone guide where I can find the return value of the above command ?

Thanks,
Shirish

--f46d0438901520adaf051301958c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am looking for the return value b=
y LTTng command, but I don&#39;t see this information in man page.</div><di=
v><br></div><div>For example return value of the following command.</div><d=
iv><div>lttng create --snapshot Testing</div><div>lttng enable-channel --us=
erspace --tracefile-size 1M --tracefile-count 1 --overwrite=C2=A0<span styl=
e=3D"font-size:12.8000001907349px">channel1</span><br></div><div>lttng enab=
le-event -u -a -c=C2=A0<span style=3D"font-size:12.8000001907349px">channel=
1</span><br></div><div>lttng start<br></div></div><div><br></div><div>Can a=
nyone guide where I can find the return value of the above command ?</div><=
div><br></div><div>Thanks,</div><div>Shirish</div></div>

--f46d0438901520adaf051301958c--


--===============0247267945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0247267945==--
