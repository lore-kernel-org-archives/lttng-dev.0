From: Divya Vyas <dvyas@mvista.com>
Subject: lttng module error
Date: Mon, 5 Jan 2015 11:28:04 +0530
Message-ID: <CA+=dQ-_34nLvPf5iJ2oV2tbJNzgCZ4ma-vYwMbm=0UPnZtFp+A__34059.6141097651$1420437557$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1859701740=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f180.google.com ([74.125.82.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dvyas@mvista.com>) id 1Y80gQ-0000af-EE
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 00:58:35 -0500
Received: by mail-we0-f180.google.com with SMTP id w62so7245395wes.11
 for <lttng-dev@lists.lttng.org>; Sun, 04 Jan 2015 21:58:24 -0800 (PST)
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

--===============1859701740==
Content-Type: multipart/alternative; boundary=047d7b5d52a6e5dba5050be160e6

--047d7b5d52a6e5dba5050be160e6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I am getting this error while building lttng-modules folder:

In function =E2=80=98lttng_statedump_process_ns=E2=80=99:
/home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c:301:2:
error: implicit declaration of function =E2=80=98task_nsproxy=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  proxy =3D task_nsproxy(p);
  ^
/home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c:301:8:
warning: assignment makes pointer from integer without a cast [enabled by
default]
  proxy =3D task_nsproxy(p);
        ^
/home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c: In
function =E2=80=98do_lttng_statedump=E2=80=99:
/home/divya/Downloads/lttng-modules-a94de96/lttng-statedump-impl.c:395:2:
error: implicit declaration of function =E2=80=98lttng_list_interrupts=E2=
=80=99
[-Werror=3Dimplicit-function-declaration]
  lttng_list_interrupts(session);

Has anybody faced this issue?

--047d7b5d52a6e5dba5050be160e6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I am getting this error while b=
uilding lttng-modules folder:<br><br>In function =E2=80=98lttng_statedump_p=
rocess_ns=E2=80=99:<br>/home/divya/Downloads/lttng-modules-a94de96/lttng-st=
atedump-impl.c:301:2: error: implicit declaration of function =E2=80=98task=
_nsproxy=E2=80=99 [-Werror=3Dimplicit-function-declaration]<br>=C2=A0 proxy=
 =3D task_nsproxy(p);<br>=C2=A0 ^<br>/home/divya/Downloads/lttng-modules-a9=
4de96/lttng-statedump-impl.c:301:8: warning: assignment makes pointer from =
integer without a cast [enabled by default]<br>=C2=A0 proxy =3D task_nsprox=
y(p);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>/home/divya/Downlo=
ads/lttng-modules-a94de96/lttng-statedump-impl.c: In function =E2=80=98do_l=
ttng_statedump=E2=80=99:<br>/home/divya/Downloads/lttng-modules-a94de96/ltt=
ng-statedump-impl.c:395:2: error: implicit declaration of function =E2=80=
=98lttng_list_interrupts=E2=80=99 [-Werror=3Dimplicit-function-declaration]=
<br>=C2=A0 lttng_list_interrupts(session);<br><br></div>Has anybody faced t=
his issue?<br><br></div>

--047d7b5d52a6e5dba5050be160e6--


--===============1859701740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1859701740==--
