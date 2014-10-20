From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: Regarding CtfTmfTrace reader in TMF and LTTng's new
	trace
Date: Mon, 20 Oct 2014 12:15:07 -0400
Message-ID: <CAKQh6phdBTr9n5GyMx2raR3za6VZGQs_dZatPO0WCE3CNpROcw__49758.0725154423$1413821772$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0962407237=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1XgFc1-0004nq-H3
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 12:15:16 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so5417753pad.8
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 09:15:07 -0700 (PDT)
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

--===============0962407237==
Content-Type: multipart/alternative; boundary=047d7b10cf3da3dbb90505dd0410

--047d7b10cf3da3dbb90505dd0410
Content-Type: text/plain; charset=UTF-8

>

  Yes, it is working in TMF views. The index folders are shown separately
in TMF and contents of the new  trace format are also complete.

I looked at the TmfStateSystemAnalysisModule class, and in particular
StateSystemEventRequest class in it at the end. I understand this class
StateSystemEventRequest but how is this ITmfStateProvider  passed to the
constructor StateSystemEventRequest(ITmfState
 Provider sp). I don't see any direct implementation of ITmfStateProvider
there.

Just to give a bit of context, in my scenario, I am interested in directly
reading traces from the hard disk without using the views in TMF. If there
are many traces in the hard disk, my program reads them one by one, perform
its analysis on them, and closes them. My program would pass the path of
the trace folder to a class implementing trace reader  and would take the
contents (Events) one by one from that class.

Thanks,
Shariyar



Date: Mon, 20 Oct 2014 10:37:26 -0400
> From: Genevi?ve Bastien <gbastien+lttng@versatic.net>
> To: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Regarding CtfTmfTrace reader in TMF and
>         LTTng's new trace format
> Message-ID: <54451E26.4090308@versatic.net>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi Shariyar,
>
> Can your trace be read all right if you import it in TMF (Trace Compass)
> and open it normally in it? Do all events appear in the events table?
> There were changes to improve the CTF reading part recently and somebody
> reported a bug with traces taken on ARM where events are not read
> correctly, but the bug is not due to the index files.
>
> If the trace is read correctly by TMF, may I suggest that you use a
> TmfEventRequest instead of your own iterator to read the trace events.
> This is the preferred way for now, most analysis do that and you don't
> have to bother about trace types, iterators, etc. For an example, see
> the class TmfStateSystemAnalysisModule, at the end of the file is the
> event request class and the build() method from the class that uses it.
>
> Genevi?ve
>
>
> On 14-10-17 11:31 AM, Shariyar wrote:
> > Hi,
> >
> > I am trying to read the traces  generated in the latest format by
> > LTTng--i.e.,  a trace having an index folder (with index files) and
> > the files for every channel. I am reading these type of traces in my
> > Java program by using the CtfTmfTrace class that exists in TMF. I have
> > been using this class and its associated classes (e.g., CtfIterator
> > and CtfTmfEvent) to successfully read the traces in previous trace
> > format of LTTng (i.e., the trace with only files for channels and no
> > index folder/files).
> >
> >  Now, I cannot read the latest trace format with these classes. In
> > fact, I am only able to read 10-20 events from the latest trace
> > format.  These events are namely power_cpu_idle, exit_syscall, and
> > sys_ioctl. Can you  kindly tell me which classes to use to read both
> > kind of trace formats; old ones and the new ones?
> >
> > I have also pasted below my current source code to read LTTng traces.
> >
> > /**
> >      * Constructor to initialize the trace
> >      * @param filePath file Name
> >      * @throws TmfTraceException An exception during trace reading
> >      */
> >     public CTFSystemCallIterator(String filePath) throws
> > TmfTraceException {
> >         fTrace = new CtfTmfTrace();
> >         fTrace.initTrace(null, filePath, CtfTmfEvent.class);
> >         fTraceIterator = fTrace.createIterator();
> >     }
> >
> >     /**
> >      * Moves Iterator to the next event, and returns true if the iterator
> >      * can advance or false if the iterator cannot advance
> >      **/
> >     @Override
> >     public boolean advance() {
> >         boolean isAdvance = true;
> >         fSyscall = ""; //$NON-NLS-1$
> >         do {
> >             CtfTmfEvent event = fTraceIterator.getCurrentEvent();
> >             System.out.println(event);
> >             fSyscall = handleSysEntryEvent(event);
> >             isAdvance = fTraceIterator.advance();
> >         } while (fSyscall.isEmpty() && isAdvance);
> >
> >         if (!isAdvance) {
> >             fIsDispose = true;
> >             fTrace.dispose();
> >         }
> >
> >         return isAdvance;
> >
> >     }
> >
> > Thanks,
> > Shariyar
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <
> http://lists.lttng.org/pipermail/lttng-dev/attachments/20141020/d05b31bc/attachment.html
> >
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> ------------------------------
>
> End of lttng-dev Digest, Vol 78, Issue 22
> *****************************************
>

--047d7b10cf3da3dbb90505dd0410
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0
</blockquote><div>=C2=A0 Yes, it is working in TMF views. The index folders=
 are shown separately in TMF and contents of the new=C2=A0 trace format are=
 also complete.<br><br></div><div>I looked at the TmfStateSystemAnalysisMod=
ule class, and in particular StateSystemEventRequest class in it at the end=
. I understand this class StateSystemEventRequest but how is this ITmfState=
Provider=C2=A0 passed to the constructor StateSystemEventRequest(ITmfState<=
/div><div>=C2=A0Provider sp). I don&#39;t see any direct implementation of =
ITmfStateProvider there. <br><br></div><div>Just to give a bit of context, =
in my scenario, I am interested in directly reading traces from the hard di=
sk without using the views in TMF. If there are many traces in the hard dis=
k, my program reads them one by one, perform its analysis on them, and clos=
es them. My program would pass the path of the trace folder to a class impl=
ementing trace reader=C2=A0 and would take the contents (Events) one by one=
 from that class.<br><br></div><div>Thanks,<br></div><div>Shariyar<br></div=
><div><br><br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">D=
ate: Mon, 20 Oct 2014 10:37:26 -0400<br>
From: Genevi?ve Bastien &lt;<a href=3D"mailto:gbastien%2Blttng@versatic.net=
">gbastien+lttng@versatic.net</a>&gt;<br>
To: <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org<=
/a><br>
Subject: Re: [lttng-dev] Regarding CtfTmfTrace reader in TMF and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LTTng&#39;s new trace format<br>
Message-ID: &lt;<a href=3D"mailto:54451E26.4090308@versatic.net">54451E26.4=
090308@versatic.net</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Hi Shariyar,<br>
<br>
Can your trace be read all right if you import it in TMF (Trace Compass)<br=
>
and open it normally in it? Do all events appear in the events table?<br>
There were changes to improve the CTF reading part recently and somebody<br=
>
reported a bug with traces taken on ARM where events are not read<br>
correctly, but the bug is not due to the index files.<br>
<br>
If the trace is read correctly by TMF, may I suggest that you use a<br>
TmfEventRequest instead of your own iterator to read the trace events.<br>
This is the preferred way for now, most analysis do that and you don&#39;t<=
br>
have to bother about trace types, iterators, etc. For an example, see<br>
the class TmfStateSystemAnalysisModule, at the end of the file is the<br>
event request class and the build() method from the class that uses it.<br>
<br>
Genevi?ve<br>
<br>
<br>
On 14-10-17 11:31 AM, Shariyar wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am trying to read the traces=C2=A0 generated in the latest format by=
<br>
&gt; LTTng--i.e.,=C2=A0 a trace having an index folder (with index files) a=
nd<br>
&gt; the files for every channel. I am reading these type of traces in my<b=
r>
&gt; Java program by using the CtfTmfTrace class that exists in TMF. I have=
<br>
&gt; been using this class and its associated classes (e.g., CtfIterator<br=
>
&gt; and CtfTmfEvent) to successfully read the traces in previous trace<br>
&gt; format of LTTng (i.e., the trace with only files for channels and no<b=
r>
&gt; index folder/files).<br>
&gt;<br>
&gt;=C2=A0 Now, I cannot read the latest trace format with these classes. I=
n<br>
&gt; fact, I am only able to read 10-20 events from the latest trace<br>
&gt; format.=C2=A0 These events are namely power_cpu_idle, exit_syscall, an=
d<br>
&gt; sys_ioctl. Can you=C2=A0 kindly tell me which classes to use to read b=
oth<br>
&gt; kind of trace formats; old ones and the new ones?<br>
&gt;<br>
&gt; I have also pasted below my current source code to read LTTng traces.<=
br>
&gt;<br>
&gt; /**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Constructor to initialize the trace<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * @param filePath file Name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * @throws TmfTraceException An exception during tr=
ace reading<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0public CTFSystemCallIterator(String filePath) throw=
s<br>
&gt; TmfTraceException {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fTrace =3D new CtfTmfTrace();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fTrace.initTrace(null, filePath, CtfT=
mfEvent.class);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fTraceIterator =3D fTrace.createItera=
tor();<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Moves Iterator to the next event, and returns tr=
ue if the iterator<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * can advance or false if the iterator cannot adva=
nce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 **/<br>
&gt;=C2=A0 =C2=A0 =C2=A0@Override<br>
&gt;=C2=A0 =C2=A0 =C2=A0public boolean advance() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boolean isAdvance =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fSyscall =3D &quot;&quot;; //$NON-NLS=
-1$<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CtfTmfEvent event =3D f=
TraceIterator.getCurrentEvent();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0System.out.println(even=
t);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fSyscall =3D handleSysE=
ntryEvent(event);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isAdvance =3D fTraceIte=
rator.advance();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (fSyscall.isEmpty() &amp;&amp=
; isAdvance);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!isAdvance) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fIsDispose =3D true;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fTrace.dispose();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return isAdvance;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Shariyar<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/attachments/=
20141020/d05b31bc/attachment.html" target=3D"_blank">http://lists.lttng.org=
/pipermail/lttng-dev/attachments/20141020/d05b31bc/attachment.html</a>&gt;<=
br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br>
<br>
------------------------------<br>
<br>
End of lttng-dev Digest, Vol 78, Issue 22<br>
*****************************************<br>
</blockquote></div><br></div></div>

--047d7b10cf3da3dbb90505dd0410--


--===============0962407237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0962407237==--
