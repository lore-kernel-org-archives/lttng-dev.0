From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: snapshot issue in lttng 2.3.0
Date: Wed, 25 Sep 2013 13:07:50 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26792DE6__38782.4375452057$1380116800$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VOoop-0005vJ-2n
	for lttng-dev@lists.lttng.org; Wed, 25 Sep 2013 09:07:56 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Thuya Aung <thuyaaung2002@yahoo.com>
List-Id: lttng-dev@lists.lttng.org

Date: Tue, 24 Sep 2013 13:42:44 -0700 (PDT)
From: Thuya Aung <thuyaaung2002@yahoo.com>

> With lttng 2.3.0 in Ubuntu 12.04 LTS, I only get the tracepoints in kerne=
l folder with snapshot mode. I do not see anything for userspace tracepoint=
s. =

> The following is the way I setup for lttng session
>
> lttng create mySession --snapshot
> lttng enable-channel kCh --buffers-global --subbuf-size=3D1048576 -k
> lttng enable-event -a -k
> lttng enable-channel uCh --buffers-uid --subbuf-size=3D1048576 -u
> lttng enable-event -a -u
> sleep 1
> lttng start mySession
> sleep 60
> lttng snapshot record
> lttng stop mySession
> lttng destroy mySession
>
> I got the error message saying "Undefined command" with the following
>
> lttng add-output -n myNewOutput file:///home/taung/output (<--- following=
 the examples of man 1 lttng)
>
> Did I do something wrong? What else I should be doing in order to use sna=
pshot feature?
>
> Thuya Aung

   I can confirm this problem (I ran my usual user-space event generator an=
d got nothing for UST in the snapshot).  Regarding your script, there is on=
e mistake made twice: when you enable-event, you need to specify the channe=
l.  You should have gotten an error ("Error: Events: Non-default channel ex=
ists within session").  The correct script lines are:

lttng enable-event -a -k -c kCh
lttng enable-event -a -u -c uCh

   As for the output, the mistake is simple.  The correct line is:

lttng snapshot add-output -n myNewOutput file:///home/taung/output

   add-output is a snapshot action, not an lttng command.  Additionally, be=
cause a snapshot output is created by default, you must delete it first (cu=
rrently there is just one output slot):

lttng snapshot del-output 1
lttng snapshot add-output -n myNewOutput file:///home/taung/output

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
