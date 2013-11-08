From: Shreyas Joshi <shreyasjoshi11@gmail.com>
Subject: Build Issue - lttng-modules - cross compiling for
	MIPSEL - syscall.h
Date: Fri, 8 Nov 2013 12:41:55 +0530
Message-ID: <CAP0pN0uFfyA1GFjcDrqQ+QML_c0eLT-jksqYS0ZAt=C+==Lo7A__7295.40086254037$1384090450$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801535130=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <shreyasjoshi11@gmail.com>) id 1VegEb-0001fp-5w
	for lttng-dev@lists.lttng.org; Fri, 08 Nov 2013 02:12:02 -0500
Received: by mail-ie0-f180.google.com with SMTP id e14so2679055iej.11
	for <lttng-dev@lists.lttng.org>; Thu, 07 Nov 2013 23:11:55 -0800 (PST)
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

--===============0801535130==
Content-Type: multipart/alternative; boundary=047d7bd75920edc7de04eaa518fd

--047d7bd75920edc7de04eaa518fd
Content-Type: text/plain; charset=ISO-8859-1

Hi,

As you are aware that in mips linux there is no such file called -

#include <asm/syscall.h>

If I comment this line, then it get the issue for this function -

error: implicit declaration of function 'syscall_get_arguments'


It cannot find the syscall_get_arguments. Do you support lttng-modules for
mips platform?
Is there any patch for it? I am stuck at the moment. Any help will be much
appreciated.

-- 
Thanks & regards

Shreyas Joshi

--047d7bd75920edc7de04eaa518fd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br>As you are aware that in mips li=
nux there is no such file called - <br><br>#include &lt;asm/syscall.h&gt;<b=
r><br></div>If I comment this line, then it get the issue for this function=
 - <br>
<br>error: implicit declaration of function &#39;syscall_get_arguments&#39;=
<br><br><br></div>It cannot find the syscall_get_arguments. Do you support =
lttng-modules for mips platform?<br></div>Is there any patch for it? I am s=
tuck at the moment. Any help will be much appreciated. <br clear=3D"all">
<div><div><div><div><div><br>-- <br>Thanks &amp; regards<br><br>Shreyas Jos=
hi
</div></div></div></div></div></div>

--047d7bd75920edc7de04eaa518fd--


--===============0801535130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0801535130==--
