From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: Need help in converting trace data into CTF
Date: Thu, 20 Jun 2019 22:11:37 +0530
Message-ID: <CAEWVvOT=geq4KRmmiQWHNF8mDqrF4H3RVt04pcMkmx1bmTCpig__35344.5245114685$1561048950$gmane$org@mail.gmail.com>
References: <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa> <20190604145312.GB13240@joraj-alpa>
 <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA@mail.gmail.com>
 <CAEWVvOR0wv2Du2KNCZE0dpNAhMaFh7JvDFG0FOQ8uWyTBpSoOw@mail.gmail.com>
 <20190617165154.GA7208@joraj-alpa>
 <CAEWVvOSXKF=Ey_edFSFp=CqUDHyhoB_iZQEdTHwcwwYNM3LpJg@mail.gmail.com>
 <20190618141714.GC7208@joraj-alpa>
 <CAEWVvOS-Xe_q7BuPiV7LEJ0Cx96tjsydYALvytvrzg-D+8TYhg@mail.gmail.com>
 <20190619171057.GB32505@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1654139142946475222=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by lists.lttng.org (Postfix) with ESMTPS id 45V6zq41Vvz18SB
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2019 12:42:15 -0400 (EDT)
Received: by mail-wr1-x42c.google.com with SMTP id n4so3683112wrw.13
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2019 09:42:15 -0700 (PDT)
In-Reply-To: <20190619171057.GB32505@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1654139142946475222==
Content-Type: multipart/alternative; boundary="0000000000002e84f4058bc4078a"

--0000000000002e84f4058bc4078a
Content-Type: text/plain; charset="UTF-8"

>
> >  I want to make babeltrace read my metadata file and event stream stored
> in
> > a file. How does babeltrace read an arbitrary CTF session(CTF+event
> stream)?
>
> Babeltrace traverses the tree and look for files named "metadata"
> . All files at the same depth of a metadata file are considered CTF
> streams.
>
> e.g:
>    /tmp/
>        my-trace/
>            another_dir/
>                abcd
>                efgh
>                metadata
>
> babeltrace /tmp/my-trace/
>
> The files "abcd" and "efgh" will be considered stream files and babeltrace
> will
> try to read them.
>
> You can have hidden file (".abcd") at the same depth, they will not be
> considered.
>
> >
> > What should be the file format to store the event stream? I will use
> > fwrite() to store the events.
>
> The CTF format.
>
> Okay. This worked for me. Thanks :)

Now I know how to write the metadata file but one thing I am not sure that
how should I relate the TSDL description of metadata with my system events?

Like I have this in my system:

typedef struct ctf_event {
  uint64_t                     ns;
  uint32_t                     cpu;
  rtems_record_event           event;
  uint64_t                     data;
} ctf_event;

How should I relate it with TSDL description of metadata? It should match
with the TSDL description. Isn't it?

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000002e84f4058bc4078a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">&gt;=C2=A0 I want to make babeltrace read my metadata fi=
le and event stream stored in<br>
&gt; a file. How does babeltrace read an arbitrary CTF session(CTF+event st=
ream)?<br>
<br>
Babeltrace traverses the tree and look for files named &quot;metadata&quot;=
<br>
. All files at the same depth of a metadata file are considered CTF streams=
.<br>
<br>
e.g:<br>
=C2=A0 =C2=A0/tmp/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0my-trace/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0another_dir/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abcd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0efgh<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metadata<br>
<br>
babeltrace /tmp/my-trace/<br>
<br>
The files &quot;abcd&quot; and &quot;efgh&quot; will be considered stream f=
iles and babeltrace will<br>
try to read them.<br>
<br>
You can have hidden file (&quot;.abcd&quot;) at the same depth, they will n=
ot be<br>
considered.<br>
<br>
&gt; <br>
&gt; What should be the file format to store the event stream? I will use<b=
r>
&gt; fwrite() to store the events.<br>
<br>
The CTF format.<br><br></blockquote><div>Okay. This worked for me. Thanks :=
)</div><div><br></div><div>Now I know how to write the metadata file but on=
e thing I am not sure that how should I relate the TSDL description of meta=
data with my system events?</div><div><br></div><div>Like I have this in my=
 system:</div><div><br></div><div>typedef struct ctf_event {<br>=C2=A0 uint=
64_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ns;<br>=C2=A0 uint32_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cpu;<br>=C2=A0 rtems_record_event =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 event;<br>=C2=A0 uint64_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data;<br>} ctf_event;<br></div><div><br>=
</div><div>How should I relate it with TSDL description of metadata? It sho=
uld match with the TSDL description. Isn&#39;t it?</div><div><br></div><div=
>Thanks</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_si=
gnature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"4"><b>Ravindr=
a Kumar Meena</b></font>,<div><span style=3D"color:rgb(102,102,102)">B. Tec=
h. Computer Science and Engineering,<br></span></div><div><span style=3D"co=
lor:rgb(102,102,102)"><a href=3D"https://www.iitism.ac.in/" style=3D"color:=
rgb(17,85,204)" target=3D"_blank">Indian Institute of Technology (Indian Sc=
hool of Mines)</a>, Dhanbad</span></div></div></div></div></div></div>

--0000000000002e84f4058bc4078a--

--===============1654139142946475222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1654139142946475222==--
