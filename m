From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Re: Regarding CtfTmfTrace reader in TMF and LTTng's new
 trace format
Date: Mon, 20 Oct 2014 10:37:26 -0400
Message-ID: <54451E26.4090308__34397.003244567$1413815911$gmane$org@versatic.net>
References: <CAKQh6pgdd+72wcGNxtCC59bQe5sGJ239fWzDsOsSUb4KToCxhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1835316178=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gbastien+lttng@versatic.net>) id 1XgE5T-000499-K1
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 10:37:35 -0400
Received: from [192.168.69.98] (unknown [96.127.235.205])
 by smtp.electronicbox.net (Postfix) with ESMTP id 7A35FDF381
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 10:34:42 -0400 (EDT)
In-Reply-To: <CAKQh6pgdd+72wcGNxtCC59bQe5sGJ239fWzDsOsSUb4KToCxhw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1835316178==
Content-Type: multipart/alternative;
 boundary="------------070500080207020507000308"

This is a multi-part message in MIME format.
--------------070500080207020507000308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Shariyar,

Can your trace be read all right if you import it in TMF (Trace Compass)
and open it normally in it? Do all events appear in the events table?
There were changes to improve the CTF reading part recently and somebody
reported a bug with traces taken on ARM where events are not read
correctly, but the bug is not due to the index files.

If the trace is read correctly by TMF, may I suggest that you use a
TmfEventRequest instead of your own iterator to read the trace events.
This is the preferred way for now, most analysis do that and you don't
have to bother about trace types, iterators, etc. For an example, see
the class TmfStateSystemAnalysisModule, at the end of the file is the
event request class and the build() method from the class that uses it.

Genevi=E8ve


On 14-10-17 11:31 AM, Shariyar wrote:
> Hi,
>
> I am trying to read the traces  generated in the latest format by
> LTTng--i.e.,  a trace having an index folder (with index files) and
> the files for every channel. I am reading these type of traces in my
> Java program by using the CtfTmfTrace class that exists in TMF. I have
> been using this class and its associated classes (e.g., CtfIterator
> and CtfTmfEvent) to successfully read the traces in previous trace
> format of LTTng (i.e., the trace with only files for channels and no
> index folder/files).
>
>  Now, I cannot read the latest trace format with these classes. In
> fact, I am only able to read 10-20 events from the latest trace
> format.  These events are namely power_cpu_idle, exit_syscall, and
> sys_ioctl. Can you  kindly tell me which classes to use to read both
> kind of trace formats; old ones and the new ones?=20
>
> I have also pasted below my current source code to read LTTng traces.
>
> /**
>      * Constructor to initialize the trace
>      * @param filePath file Name
>      * @throws TmfTraceException An exception during trace reading
>      */
>     public CTFSystemCallIterator(String filePath) throws
> TmfTraceException {
>         fTrace =3D new CtfTmfTrace();
>         fTrace.initTrace(null, filePath, CtfTmfEvent.class);
>         fTraceIterator =3D fTrace.createIterator();
>     }
>
>     /**
>      * Moves Iterator to the next event, and returns true if the iterat=
or
>      * can advance or false if the iterator cannot advance
>      **/
>     @Override
>     public boolean advance() {
>         boolean isAdvance =3D true;
>         fSyscall =3D ""; //$NON-NLS-1$
>         do {
>             CtfTmfEvent event =3D fTraceIterator.getCurrentEvent();
>             System.out.println(event);
>             fSyscall =3D handleSysEntryEvent(event);
>             isAdvance =3D fTraceIterator.advance();
>         } while (fSyscall.isEmpty() && isAdvance);
>
>         if (!isAdvance) {
>             fIsDispose =3D true;
>             fTrace.dispose();
>         }
>
>         return isAdvance;
>
>     }
>
> Thanks,
> Shariyar
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------070500080207020507000308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Shariyar,<br>
      <br>
      Can your trace be read all right if you import it in TMF (Trace
      Compass) and open it normally in it? Do all events appear in the
      events table? There were changes to improve the CTF reading part
      recently and somebody reported a bug with traces taken on ARM
      where events are not read correctly, but the bug is not due to the
      index files.<br>
      <br>
      If the trace is read correctly by TMF, may I suggest that you use
      a TmfEventRequest instead of your own iterator to read the trace
      events. This is the preferred way for now, most analysis do that
      and you don't have to bother about trace types, iterators, etc.
      For an example, see the class TmfStateSystemAnalysisModule, at the
      end of the file is the event request class and the build() method
      from the class that uses it.<br>
      <br>
      Genevi&egrave;ve<br>
      <br>
      <br>
      On 14-10-17 11:31 AM, Shariyar wrote:<br>
    </div>
    <blockquote
cite="mid:CAKQh6pgdd+72wcGNxtCC59bQe5sGJ239fWzDsOsSUb4KToCxhw@mail.gmail.com"
      type="cite">
      <div dir="ltr">Hi,
        <div><br>
        </div>
        <div>I am trying to read the traces &nbsp;generated in the latest
          format by LTTng--i.e., &nbsp;a trace having an index folder (with
          index files) and the files for every channel. I am reading
          these type of traces in my Java program by using the
          CtfTmfTrace class that exists in TMF. I have been using this
          class and its associated classes (e.g., CtfIterator
          and&nbsp;CtfTmfEvent) to successfully read the traces in previous
          trace format of LTTng (i.e., the trace with only files for
          channels and no index folder/files).</div>
        <div><br>
        </div>
        <div>&nbsp;Now, I cannot read the latest trace format with these
          classes. In fact, I am only able to read 10-20 events from the
          latest trace format.&nbsp; These events are namely power_cpu_idle,
          exit_syscall, and sys_ioctl. Can you &nbsp;kindly tell me which
          classes to use to read both kind of trace formats; old ones
          and the new ones?&nbsp;</div>
        <div><br>
        </div>
        <div>I have also pasted below my current source code to read
          LTTng traces.</div>
        <div><br>
        </div>
        <div>
          <div>/**</div>
          <div>&nbsp; &nbsp; &nbsp;* Constructor to initialize the trace</div>
          <div>&nbsp; &nbsp; &nbsp;* @param filePath file Name</div>
          <div>&nbsp; &nbsp; &nbsp;* @throws TmfTraceException An exception during
            trace reading</div>
          <div>&nbsp; &nbsp; &nbsp;*/</div>
          <div>&nbsp; &nbsp; public CTFSystemCallIterator(String filePath) throws
            TmfTraceException {</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; fTrace = new CtfTmfTrace();</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; fTrace.initTrace(null, filePath,
            CtfTmfEvent.class);</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; fTraceIterator = fTrace.createIterator();</div>
          <div>&nbsp; &nbsp; }</div>
          <div><br>
          </div>
          <div>&nbsp; &nbsp; /**</div>
          <div>&nbsp; &nbsp; &nbsp;* Moves Iterator to the next event, and returns true
            if the iterator</div>
          <div>&nbsp; &nbsp; &nbsp;* can advance or false if the iterator cannot
            advance</div>
          <div>&nbsp; &nbsp; &nbsp;**/</div>
          <div>&nbsp; &nbsp; @Override</div>
          <div>&nbsp; &nbsp; public boolean advance() {</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; boolean isAdvance = true;</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; fSyscall = ""; //$NON-NLS-1$</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; do {</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CtfTmfEvent event =
            fTraceIterator.getCurrentEvent();</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; System.out.println(event);</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fSyscall = handleSysEntryEvent(event);</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; isAdvance = fTraceIterator.advance();</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; } while (fSyscall.isEmpty() &amp;&amp;
            isAdvance);</div>
          <div><br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; if (!isAdvance) {</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fIsDispose = true;</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fTrace.dispose();</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
          <div><br>
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; return isAdvance;</div>
          <div><br>
          </div>
          <div>&nbsp; &nbsp; }</div>
        </div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Shariyar</div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070500080207020507000308--


--===============1835316178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1835316178==--
