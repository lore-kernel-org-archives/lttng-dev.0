From: Robert Daniels <robert.daniels@vantagecontrols.com>
Subject: ARM C++ segfaulting - follow-up
Date: Thu, 7 May 2015 14:41:17 +0000
Message-ID: <1431009677311.26279__48253.0050249354$1431009773$gmane$org@vantagecontrols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-db3on0117.outbound.protection.outlook.com
 ([157.55.234.117] helo=emea01-db3-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <robert.daniels@vantagecontrols.com>)
 id 1YqMzP-0007WJ-0R
 for lttng-dev@lists.lttng.org; Thu, 07 May 2015 10:41:36 -0400
Content-Language: en-US
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

> I'm attempting to use lttng userspace tracing with a C++ application on a=
n ARM platform. I'm using
> GCC 4.8.4 on Linux 3.14 with the 2.6 release of lttng. I've compiled lttn=
g-modules, lttng-ust, and
> lttng-tools and have been able to get a simple test working with C code. =
When I attempt to run the
> hello.cxx test on my target it will segfault.


I spent a little time digging into this issue and finally discovered the ca=
use of my segfault with ARM C++ tracepoints.

There is a struct called 'lttng_event' in ust-events.h which contains an em=
pty union 'u'.  This was the cause of my issue.  Under C, this empty union =
compiles to a zero byte member while under C++ it compiles to a one byte me=
mber, and in my case was four-byte aligned which caused my C++ code to have=
 the 'cds_list_head node' offset incorrectly by four bytes.  This lead to a=
n incorrect linked list structure which caused my issue.

Since this union is empty, I simply removed it from the struct and everythi=
ng worked correctly.

I don't know the history or purpose behind this empty union so I'd like to =
know if this is a safe fix.  If it is I can submit a patch with the union r=
emoved.

Thanks,

Robert Daniels


________________________________

Ce message, ainsi que tous les fichiers joints =E0 ce message, peuvent cont=
enir des informations sensibles et/ ou confidentielles ne devant pas =EAtre=
 divulgu=E9es. Si vous n'=EAtes pas le destinataire de ce message (ou que v=
ous recevez ce message par erreur), nous vous remercions de le notifier imm=
=E9diatement =E0 son exp=E9diteur, et de d=E9truire ce message. Toute copie=
, divulgation, modification, utilisation ou diffusion, non autoris=E9e, dir=
ecte ou indirecte, de tout ou partie de ce message, est strictement interdi=
te.
Se d=E9sabonner: Si vous souhaitez =EAtre retir=E9 de notre liste de diffus=
ion, s'il vous pla=EEt envoyer vos coordonn=E9es =E0 CASL.unsubscribe@legra=
nd.ca<mailto:casl.unsubscribe@legrand.ca> et indiquer quels sont les messag=
es que vous ne souhaitez plus recevoir.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.
Unsubscribe: If you would like to be removed from our mailing list, please =
send your contact information to CASL.unsubscribe@legrand.ca<mailto:casl.un=
subscribe@legrand.ca> and indicate what messages you no longer wish to rece=
ive.
