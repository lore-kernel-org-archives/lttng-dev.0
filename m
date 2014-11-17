From: Anand Neeli <anand.neeli@gmail.com>
Subject: Error in lttng_ust_exit()
Date: Mon, 17 Nov 2014 20:31:08 +0530
Message-ID: <CAM5kDqzqwG5hdHTiKJ6wC65RFhLE=0=Jcv_0V7_d7M6xOR012Q__33562.1871323839$1416236525$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0469506096=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XqNnm-0001Sm-JS
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 10:01:16 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so5827300wgg.28
 for <lttng-dev@lists.lttng.org>; Mon, 17 Nov 2014 07:01:09 -0800 (PST)
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

--===============0469506096==
Content-Type: multipart/alternative; boundary=047d7b86cb68a56afc05080f3f90

--047d7b86cb68a56afc05080f3f90
Content-Type: text/plain; charset=UTF-8

Hi All,

libust[29040/29040]: Error: Error cancelling global ust listener thread: No
such process (in lttng_ust_exit() at lttng-ust-comm.c:1517)
libust[29040/29040]: Error: Error cancelling local ust listener thread: No
such process (in lttng_ust_exit() at lttng-ust-comm.c:1526)
libust[29043/29043]: Error: Error cancelling global ust listener thread: No
such process (in lttng_ust_exit() at lttng-ust-comm.c:1517)
libust[29043/29043]: Error: Error cancelling local ust listener thread: No
such process (in lttng_ust_exit() at lttng-ust-comm.c:1526)


I'm getting above error when running an app on i386 where lttng is not
installed, i'm linking the libraries by giving LD_LIBRARY_PATH. I'm using
4.2.1 version on lttng libraries.

I think this is coming from destructor in lttng_ust. In what cases will
these will come. My app uses system() calls which does fork(), exec() and
exit().

Can anyone pls help.

Thanks,
Anand Neeli

--047d7b86cb68a56afc05080f3f90
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div><div>libust[29040/29040]: Error=
: Error cancelling global ust listener thread: No such process (in lttng_us=
t_exit() at lttng-ust-comm.c:1517)</div><div>libust[29040/29040]: Error: Er=
ror cancelling local ust listener thread: No such process (in lttng_ust_exi=
t() at lttng-ust-comm.c:1526)</div><div>libust[29043/29043]: Error: Error c=
ancelling global ust listener thread: No such process (in lttng_ust_exit() =
at lttng-ust-comm.c:1517)</div><div>libust[29043/29043]: Error: Error cance=
lling local ust listener thread: No such process (in lttng_ust_exit() at lt=
tng-ust-comm.c:1526)</div></div><div><br></div><div><br></div><div>I&#39;m =
getting above error when running an app on i386 where lttng is not installe=
d, i&#39;m linking the libraries by giving LD_LIBRARY_PATH. I&#39;m using 4=
.2.1 version on lttng libraries.</div><div><br></div><div>I think this is c=
oming from destructor in lttng_ust. In what cases will these will come. My =
app uses system() calls which does fork(), exec() and exit().=C2=A0</div><d=
iv><br></div><div>Can anyone pls help.</div><div><br></div><div>Thanks,</di=
v><div>Anand Neeli</div></div>

--047d7b86cb68a56afc05080f3f90--


--===============0469506096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0469506096==--
