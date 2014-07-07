From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: LTTng not generating trace contents
Date: Mon, 07 Jul 2014 14:04:02 -0400
Message-ID: <53BAE112.4000809__17788.3343691521$1404756292$gmane$org@voxpopuli.im>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C729D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAKQh6pjJ9SUFKtLwONVySiPbtP-udZCfs9L87mGszPVPCu2PKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0364535054=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1X4DGj-0000uN-7r
 for lttng-dev@lists.lttng.org; Mon, 07 Jul 2014 14:04:04 -0400
In-Reply-To: <CAKQh6pjJ9SUFKtLwONVySiPbtP-udZCfs9L87mGszPVPCu2PKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shariyar <syed.shariyar@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0364535054==
Content-Type: multipart/alternative;
 boundary="------------000007020701050904020006"

This is a multi-part message in MIME format.
--------------000007020701050904020006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id s67I4HSo004584

Hi,

Could you just do
$ sudo apt-get install --reinstall lttng-modules-dkms

and check in the output if you have any errors, or if it really installs=20
successfully?

Maybe Ubuntu's patches already trickled down to 12.04 and you might be=20
hitting https://bugs.lttng.org/issues/814


Thanks,
Alexandre


On 07/07/2014 01:43 PM, Shariyar wrote:
>   lttng --version,
>      lttng (LTTng Trace Control) 2.4.1 - =C9poque Opaque
>
>   lttng-sessiond --version
>      2.4.1
>
>
> I removed all LTTng packages from the system by manually searching in d=
pkg
> and reinstalled it as follows:
> sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
>
> The ppa in the system is: http://ppa.launchpad.net/lttng/ppa/ubuntu
>
> Now, I get the following error:
> sudo lttng list -k
> Error: Unable to list kernel events: Kernel tracer not available
> Error: Command error
>
> I have encountered this problem on two different systems running Ubuntu
> 12.04, after the update of system and LTTng
>
> Regards,
> Shariyar
>
>
> On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel <
> Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>
>> ----------------------------------------------------------------------
>> Date: Sun, 6 Jul 2014 18:49:51 -0400
>> From: Shariyar <syed.shariyar@gmail.com>
>>
>>> I am having a problem in generating a kernel trace using the latest
>> LTTng on Ubuntu 12.04.
>>> It was working fine previously but when I updated LTTng it stopped
>> generating the trace contents. I did an uninstall and reinstall but it
>> didn't work either.
>> ----------------------------------------------------------------------
>>
>>     Please define what you mean by "the latest LTTng".  What are the
>> versions?  ($ lttng --version, $ lttng-sessiond --version)
>>
>> Daniel U. Thibault
>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection =
&
>> Countermeasures (SPC)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Crit=
ical
>> Cyber Security (MCCS)
>> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
>> Centre
>> 2459 route de la Bravoure
>> Qu=E9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------000007020701050904020006
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    Could you just do<br>
    $ sudo apt-get install --reinstall lttng-modules-dkms<br>
    <br>
    and check in the output if you have any errors, or if it really
    installs successfully?<br>
    <br>
    Maybe Ubuntu's patches already trickled down to 12.04 and you might
    be hitting <a class="moz-txt-link-freetext" href="https://bugs.lttng.org/issues/814">https://bugs.lttng.org/issues/814</a><br>
    <br>
    <br>
    Thanks,<br>
    Alexandre<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 07/07/2014 01:43 PM, Shariyar wrote:<br>
    </div>
    <blockquote
cite="mid:CAKQh6pjJ9SUFKtLwONVySiPbtP-udZCfs9L87mGszPVPCu2PKA@mail.gmail.com"
      type="cite">
      <pre wrap=""> lttng --version,
    lttng (LTTng Trace Control) 2.4.1 - &Eacute;poque Opaque

 lttng-sessiond --version
    2.4.1


I removed all LTTng packages from the system by manually searching in dpkg
and reinstalled it as follows:
sudo apt-get install lttng-tools lttng-modules-dkms babeltrace

The ppa in the system is: <a class="moz-txt-link-freetext" href="http://ppa.launchpad.net/lttng/ppa/ubuntu">http://ppa.launchpad.net/lttng/ppa/ubuntu</a>

Now, I get the following error:
sudo lttng list -k
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

I have encountered this problem on two different systems running Ubuntu
12.04, after the update of system and LTTng

Regards,
Shariyar


On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel &lt;
<a class="moz-txt-link-abbreviated" href="mailto:Daniel.Thibault@drdc-rddc.gc.ca">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt; wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">----------------------------------------------------------------------
Date: Sun, 6 Jul 2014 18:49:51 -0400
From: Shariyar <a class="moz-txt-link-rfc2396E" href="mailto:syed.shariyar@gmail.com">&lt;syed.shariyar@gmail.com&gt;</a>

</pre>
        <blockquote type="cite">
          <pre wrap="">I am having a problem in generating a kernel trace using the latest
</pre>
        </blockquote>
        <pre wrap="">LTTng on Ubuntu 12.04.
</pre>
        <blockquote type="cite">
          <pre wrap="">It was working fine previously but when I updated LTTng it stopped
</pre>
        </blockquote>
        <pre wrap="">generating the trace contents. I did an uninstall and reinstall but it
didn't work either.
----------------------------------------------------------------------

   Please define what you mean by "the latest LTTng".  What are the
versions?  ($ lttng --version, $ lttng-sessiond --version)

Daniel U. Thibault
Protection des syst&egrave;mes et contremesures (PSC) | Systems Protection &amp;
Countermeasures (SPC)
Cyber s&eacute;curit&eacute; pour les missions essentielles (CME) | Mission Critical
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
Centre
2459 route de la Bravoure
Qu&eacute;bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <a class="moz-txt-link-rfc2396E" href="http://www.travelgis.com/map.asp?addr=918V%20QSDJ">&lt;http://www.travelgis.com/map.asp?addr=918V%20QSDJ&gt;</a>
Gouvernement du Canada | Government of Canada
<a class="moz-txt-link-rfc2396E" href="http://www.valcartier.drdc-rddc.gc.ca/">&lt;http://www.valcartier.drdc-rddc.gc.ca/&gt;</a>

</pre>
      </blockquote>
      <pre wrap="">
</pre>
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

--------------000007020701050904020006--


--===============0364535054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0364535054==--
