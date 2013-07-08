From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Is lttng namespace-ready?
Date: Mon, 8 Jul 2013 20:44:53 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD134230A8__11027.6675587103$1373316340$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UwIIq-0000Jg-WA
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 16:44:57 -0400
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
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Date: Mon, 8 Jul 2013 12:33:41 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> >    But what of per-UID traces?  What happens to a trace in progress if
> >    one or more processes switch user namespaces?
>
> nothing.
>
> >  Presumably new
> >    sub-directories would be created under "session-name/ust/uid/"?
>
> no.

   Back on 26 Jun 2013, you said:

> Subject: Re: [lttng-dev] [RELEASE] LTTng Tools 2.2.0 - Cuda (STABLE)
> Message-ID: <20130626211926.GC4725@Krystal>
...
> > I also presume the uid used [in the path (e.g. $HOME/lttng-traces/sessi=
on-20130611-1223344/ust/uid/1000/64-bit)] is the real uid (ruid)?
>
> yes, this is correct. The one returned by getuid().

   This getuid() call occurs from the tracepoint provider attached to the i=
nstrumented application, right?  If user namespaces are in use, this will t=
herefore be the virtual uid, and if a process is cloned() into a new user n=
amespace it will thus tell the daemons that its events are issuing from tha=
t virtual uid.  If it is a heretofore unknown uid, a new subdirectory shoul=
d thus appear under /ust/uid.  If it is an already known uid (more precisel=
y, an already-encountered numerical value), its events should just flow int=
o the existing channel files.  There is (I suspect) no risk of trace files =
being overwritten accidentally.

   The difficulty lies at the analysis end, if the user wants to sort out e=
vent streams that issue from the same numerical virtual uids but that are a=
ctually different (issuing from different real uids or from different user =
namespaces).  One could figure it out manually by capturing namespace API e=
vents (clone(), unshared() and setns()), but it would be nicer if lttng's m=
etadata held this information or if lttv did it for us, wouldn't it?  Maybe=
 the namespace identifiers could be added as context using enable-event?

   Another question that occurs to me as I write this is: will a given real=
 uid's lttng-consumerd daemon service the processes belonging to this uid a=
nd its subordinate user namespaces, or will each new user namespace spawn a=
 new lttng-consumerd daemon?  Is the answer the same in the per-pid and per=
-uid cases?

> >    What about the case where two processes run by two different users (=
and thus being recorded under different uid subdirectories) switch
> >    to private user namespaces which happen to both map to the same nume=
rical virtual uid?  We need to make sure the second process
> >    switch does not overwrite the trace files of the first (recall that =
per-uid trace paths do not include timestamps like per-pid trace
> >    paths do).
>
> Disambiguation between different PIDs requires the vpid context if you us=
e per-UID buffers.

   As a user, I'd probably be better off using the pid (real pid) context. =
 It would disambiguate between unrelated processes bearing the same vpids.

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
