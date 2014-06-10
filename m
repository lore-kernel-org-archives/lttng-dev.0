From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-ust] Fix: remove weak attribute from
 __start___tracepoints_ptrs and __stop___tracepoints_ptrs
Date: Tue, 10 Jun 2014 17:27:19 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359BEDC9__23480.7578767233$1402421312$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WuPpV-0001cl-SG
 for lttng-dev@lists.lttng.org; Tue, 10 Jun 2014 13:27:31 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Tue, 10 Jun 2014 09:13:54 +0200

>> Does it work well if the program and/or libraries do the following:
>>
>> - they include tracepoint.h,
>> - but they don't contain any tracepoint (so there is technically no
>>    _tracepoint_ptrs section)
>>
>> Has this case been tested ? I remember that the weak was there for this
>> peculiar corner case.
>
>I tested it exactly the way you described, and yes, it works.
>*HOWEVER*, if prior to including tracepoint.h the program also #defines =

>TRACEPOINT_DEFINE, *THEN* we have the problem you described:
>
>root@kmeter1:~# cat foo.c
>
>#define TRACEPOINT_DEFINE
>#include <lttng/tracepoint.h>
>
>int main(void)
>{
>   printf("Hello world!\n");
>}
>root@kmeter1:~# gcc foo.c -llttng-ust -ldl
>/tmp/cc92SYHX.o: In function `__tracepoints__ptrs_init':
>foo.c:(.text+0x39a): undefined reference to `__stop___tracepoints_ptrs'
>foo.c:(.text+0x39e): undefined reference to `__stop___tracepoints_ptrs'
>[...]
>/tmp/cc92SYHX.o:foo.c:(.text+0x44a): more undefined references to =

>`__start___tracepoints_ptrs' follow
>/usr/lib/gcc/powerpc-linux/4.7.2/../../../../powerpc-linux/bin/ld: =

>a.out: hidden symbol `__stop___tracepoints_ptrs' isn't defined
>/usr/lib/gcc/powerpc-linux/4.7.2/../../../../powerpc-linux/bin/ld: final =

>link failed: Bad value
>collect2: error: ld returned 1 exit status
>
>Re-adding the weak attribute "fixes" this (though it leaves us with a =

>much bigger issue, in my opinion).
>
>However, I'm not sure whether:
>
>a) this is really a use case (defining TRACEPOINT_DEFINE and then not =

>really defining any), and even so, whether
>
>b) what we have with the weak attribute is really what we want. In the =

>end, we would be defining a function with __attribute__((constructor)) =

> (oh wait, potentially even more than one!) without actually having any =

>tracepoint available. OK, the above complaints are probably not the most =

>intuitive in the world, but isn't that better than an application =

>silently "failing" (to provide any tracepoint) at runtime?
>
>After all, the issue with the above messages is about the linker trying =

>to resolve those symbols; but that's because they are used by =

>__tracepoints__ptrs_init() and friends, not because they are merely =

>declared.
>
>Any thoughts?
>
>Gerlando
----------------------------------------------------------------------

   If the issue is to protect against TRACEPOINT_DEFINE not being 'fulfille=
d' before hitting lttng/tracepoint.h, maybe tracepoint.h should check for T=
RACEPOINT_PROVIDER in addition to TRACEPOINT_DEFINE.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
