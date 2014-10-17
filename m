From: Shariyar <syed.shariyar@gmail.com>
Subject: Regarding CtfTmfTrace reader in TMF and LTTng's new
	trace format
Date: Fri, 17 Oct 2014 11:31:46 -0400
Message-ID: <CAKQh6pgdd+72wcGNxtCC59bQe5sGJ239fWzDsOsSUb4KToCxhw__1421.45653157986$1413559977$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0883687251=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1Xf9VR-0007mQ-2y
 for lttng-dev@lists.lttng.org; Fri, 17 Oct 2014 11:31:55 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so963638pdb.25
 for <lttng-dev@lists.lttng.org>; Fri, 17 Oct 2014 08:31:46 -0700 (PDT)
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

--===============0883687251==
Content-Type: multipart/alternative; boundary=047d7bdc942a15cfc50505a0103c

--047d7bdc942a15cfc50505a0103c
Content-Type: text/plain; charset=UTF-8

Hi,

I am trying to read the traces  generated in the latest format by
LTTng--i.e.,  a trace having an index folder (with index files) and the
files for every channel. I am reading these type of traces in my Java
program by using the CtfTmfTrace class that exists in TMF. I have been
using this class and its associated classes (e.g., CtfIterator
and CtfTmfEvent) to successfully read the traces in previous trace format
of LTTng (i.e., the trace with only files for channels and no index
folder/files).

 Now, I cannot read the latest trace format with these classes. In fact, I
am only able to read 10-20 events from the latest trace format.  These
events are namely power_cpu_idle, exit_syscall, and sys_ioctl. Can you
 kindly tell me which classes to use to read both kind of trace formats;
old ones and the new ones?

I have also pasted below my current source code to read LTTng traces.

/**
     * Constructor to initialize the trace
     * @param filePath file Name
     * @throws TmfTraceException An exception during trace reading
     */
    public CTFSystemCallIterator(String filePath) throws TmfTraceException {
        fTrace = new CtfTmfTrace();
        fTrace.initTrace(null, filePath, CtfTmfEvent.class);
        fTraceIterator = fTrace.createIterator();
    }

    /**
     * Moves Iterator to the next event, and returns true if the iterator
     * can advance or false if the iterator cannot advance
     **/
    @Override
    public boolean advance() {
        boolean isAdvance = true;
        fSyscall = ""; //$NON-NLS-1$
        do {
            CtfTmfEvent event = fTraceIterator.getCurrentEvent();
            System.out.println(event);
            fSyscall = handleSysEntryEvent(event);
            isAdvance = fTraceIterator.advance();
        } while (fSyscall.isEmpty() && isAdvance);

        if (!isAdvance) {
            fIsDispose = true;
            fTrace.dispose();
        }

        return isAdvance;

    }

Thanks,
Shariyar

--047d7bdc942a15cfc50505a0103c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am trying to read the traces =C2=
=A0generated in the latest format by LTTng--i.e., =C2=A0a trace having an i=
ndex folder (with index files) and the files for every channel. I am readin=
g these type of traces in my Java program by using the CtfTmfTrace class th=
at exists in TMF. I have been using this class and its associated classes (=
e.g., CtfIterator and=C2=A0CtfTmfEvent) to successfully read the traces in =
previous trace format of LTTng (i.e., the trace with only files for channel=
s and no index folder/files).</div><div><br></div><div>=C2=A0Now, I cannot =
read the latest trace format with these classes. In fact, I am only able to=
 read 10-20 events from the latest trace format.=C2=A0 These events are nam=
ely power_cpu_idle, exit_syscall, and sys_ioctl. Can you =C2=A0kindly tell =
me which classes to use to read both kind of trace formats; old ones and th=
e new ones?=C2=A0</div><div><br></div><div>I have also pasted below my curr=
ent source code to read LTTng traces.</div><div><br></div><div><div>/**</di=
v><div>=C2=A0 =C2=A0 =C2=A0* Constructor to initialize the trace</div><div>=
=C2=A0 =C2=A0 =C2=A0* @param filePath file Name</div><div>=C2=A0 =C2=A0 =C2=
=A0* @throws TmfTraceException An exception during trace reading</div><div>=
=C2=A0 =C2=A0 =C2=A0*/</div><div>=C2=A0 =C2=A0 public CTFSystemCallIterator=
(String filePath) throws TmfTraceException {</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fTrace =3D new CtfTmfTrace();</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fTrace.initTrace(null, filePath, CtfTmfEvent.class);</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 fTraceIterator =3D fTrace.createIterator();</div><div>=C2=
=A0 =C2=A0 }</div><div><br></div><div>=C2=A0 =C2=A0 /**</div><div>=C2=A0 =
=C2=A0 =C2=A0* Moves Iterator to the next event, and returns true if the it=
erator</div><div>=C2=A0 =C2=A0 =C2=A0* can advance or false if the iterator=
 cannot advance</div><div>=C2=A0 =C2=A0 =C2=A0**/</div><div>=C2=A0 =C2=A0 @=
Override</div><div>=C2=A0 =C2=A0 public boolean advance() {</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 boolean isAdvance =3D true;</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 fSyscall =3D &quot;&quot;; //$NON-NLS-1$</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 do {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 CtfTmfEvent event =3D fTraceIterator.getCurrentEvent();</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 System.out.println(event);</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fSyscall =3D handleSysEntryEvent=
(event);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isAdvance =3D =
fTraceIterator.advance();</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (fS=
yscall.isEmpty() &amp;&amp; isAdvance);</div><div><br></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (!isAdvance) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 fIsDispose =3D true;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 fTrace.dispose();</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</di=
v><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return isAdvance;</div><d=
iv><br></div><div>=C2=A0 =C2=A0 }</div></div><div><br></div><div>Thanks,</d=
iv><div>Shariyar</div></div>

--047d7bdc942a15cfc50505a0103c--


--===============0883687251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0883687251==--
