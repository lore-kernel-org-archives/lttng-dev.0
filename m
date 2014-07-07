From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: LTTng not generating trace contents
Date: Mon, 7 Jul 2014 14:21:05 -0400
Message-ID: <CAKQh6pjFRnLNHrRBL5YSzJgaOxoAL98jHAFjOAX=GVOptE5Cog__23910.6094035835$1404757343$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C729D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAKQh6pjJ9SUFKtLwONVySiPbtP-udZCfs9L87mGszPVPCu2PKA@mail.gmail.com>
 <53BAE112.4000809@voxpopuli.im>
 <CAKQh6ph1Ck-aR0PJ_YZoFxF9R1gogh4xGORaoCWDiH55QcxTkg@mail.gmail.com>
 <53BAE408.6070601@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1948827505=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1X4DXL-00016X-4c
 for lttng-dev@lists.lttng.org; Mon, 07 Jul 2014 14:21:17 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so5849920pac.39
 for <lttng-dev@lists.lttng.org>; Mon, 07 Jul 2014 11:21:05 -0700 (PDT)
In-Reply-To: <53BAE408.6070601@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1948827505==
Content-Type: multipart/alternative; boundary=047d7b6d8244cc6ac304fd9e892d

--047d7b6d8244cc6ac304fd9e892d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Or maybe upgrading to Ubuntu 14.04 could solve this issue as MySQL server
stopped working too in both Ubuntu 12.04 systems.

Regards,
Shariyar


On Mon, Jul 7, 2014 at 2:16 PM, Alexandre Montplaisir <
alexmonthy@voxpopuli.im> wrote:

> Great, thanks for testing, that means we'll have to backport Julien's
> patch to the stable packages earlier than expected!
>
> I'll try to update these this afternoon, I'll keep you posted.
>
> Cheers,
> Alexandre
>
>
> On 07/07/2014 02:11 PM, Shariyar wrote:
>
>> No it didn't install correctly.It is generating a crash report and
>> lttng-module-dkms exists in it too.
>>
>>
>> Regards,
>> Shariyar
>>
>>
>> On Mon, Jul 7, 2014 at 2:04 PM, Alexandre Montplaisir <
>> alexmonthy@voxpopuli.im> wrote:
>>
>>    Hi,
>>>
>>> Could you just do
>>> $ sudo apt-get install --reinstall lttng-modules-dkms
>>>
>>> and check in the output if you have any errors, or if it really install=
s
>>> successfully?
>>>
>>> Maybe Ubuntu's patches already trickled down to 12.04 and you might be
>>> hitting https://bugs.lttng.org/issues/814
>>>
>>>
>>> Thanks,
>>> Alexandre
>>>
>>>
>>>
>>> On 07/07/2014 01:43 PM, Shariyar wrote:
>>>
>>>   lttng --version,
>>>      lttng (LTTng Trace Control) 2.4.1 - =C3=89poque Opaque
>>>
>>>   lttng-sessiond --version
>>>      2.4.1
>>>
>>>
>>> I removed all LTTng packages from the system by manually searching in
>>> dpkg
>>> and reinstalled it as follows:
>>> sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
>>>
>>> The ppa in the system is: http://ppa.launchpad.net/lttng/ppa/ubuntu
>>>
>>> Now, I get the following error:
>>> sudo lttng list -k
>>> Error: Unable to list kernel events: Kernel tracer not available
>>> Error: Command error
>>>
>>> I have encountered this problem on two different systems running Ubuntu
>>> 12.04, after the update of system and LTTng
>>>
>>> Regards,
>>> Shariyar
>>>
>>>
>>> On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel <
>>> Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>>>
>>>
>>>   ---------------------------------------------------------------------=
-
>>> Date: Sun, 6 Jul 2014 18:49:51 -0400
>>> From: Shariyar <syed.shariyar@gmail.com> <syed.shariyar@gmail.com>
>>>
>>>
>>>   I am having a problem in generating a kernel trace using the latest
>>>
>>>   LTTng on Ubuntu 12.04.
>>>
>>>   It was working fine previously but when I updated LTTng it stopped
>>>
>>>   generating the trace contents. I did an uninstall and reinstall but i=
t
>>> didn't work either.
>>> ----------------------------------------------------------------------
>>>
>>>     Please define what you mean by "the latest LTTng".  What are the
>>> versions?  ($ lttng --version, $ lttng-sessiond --version)
>>>
>>> Daniel U. Thibault
>>> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protectio=
n &
>>> Countermeasures (SPC)
>>> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission=
 Critical
>>> Cyber Security (MCCS)
>>> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
>>> Centre
>>> 2459 route de la Bravoure
>>> Qu=C3=A9bec QC  G3J 1X5
>>> CANADA
>>> Vox : (418) 844-4000 x4245
>>> Fax : (418) 844-4538
>>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <
>>> http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>>> Gouvernement du Canada | Government of Canada<http://www.valcartier.
>>> drdc-rddc.gc.ca/> <http://www.valcartier.drdc-rddc.gc.ca/>
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://
>>> lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>>
>>>
>

--047d7b6d8244cc6ac304fd9e892d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Or maybe upgrading to Ubuntu 14.04 could solve this issue =
as MySQL server stopped working too in both Ubuntu 12.04 systems.<div><br><=
/div><div>Regards,</div><div>Shariyar</div></div><div class=3D"gmail_extra"=
>
<br><br><div class=3D"gmail_quote">On Mon, Jul 7, 2014 at 2:16 PM, Alexandr=
e Montplaisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpopuli.=
im" target=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
Great, thanks for testing, that means we&#39;ll have to backport Julien&#39=
;s patch to the stable packages earlier than expected!<br>
<br>
I&#39;ll try to update these this afternoon, I&#39;ll keep you posted.<br>
<br>
Cheers,<br>
Alexandre<div><div class=3D"h5"><br>
<br>
On 07/07/2014 02:11 PM, Shariyar wrote:<br>
</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5">
No it didn&#39;t install correctly.It is generating a crash report and<br>
lttng-module-dkms exists in it too.<br>
<br>
<br>
Regards,<br>
Shariyar<br>
<br>
<br>
On Mon, Jul 7, 2014 at 2:04 PM, Alexandre Montplaisir &lt;<br>
<a href=3D"mailto:alexmonthy@voxpopuli.im" target=3D"_blank">alexmonthy@vox=
populi.im</a>&gt; wrote:<br>
<br>
</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5">
=C2=A0 Hi,<br>
<br>
Could you just do<br>
$ sudo apt-get install --reinstall lttng-modules-dkms<br>
<br>
and check in the output if you have any errors, or if it really installs<br=
>
successfully?<br>
<br>
Maybe Ubuntu&#39;s patches already trickled down to 12.04 and you might be<=
br>
hitting <a href=3D"https://bugs.lttng.org/issues/814" target=3D"_blank">htt=
ps://bugs.lttng.org/issues/<u></u>814</a><br>
<br>
<br>
Thanks,<br>
Alexandre<br>
<br>
<br>
<br>
On 07/07/2014 01:43 PM, Shariyar wrote:<br>
<br>
=C2=A0 lttng --version,<br>
=C2=A0 =C2=A0 =C2=A0lttng (LTTng Trace Control) 2.4.1 - =C3=89poque Opaque<=
br>
<br>
=C2=A0 lttng-sessiond --version<br>
=C2=A0 =C2=A0 =C2=A02.4.1<br>
<br>
<br>
I removed all LTTng packages from the system by manually searching in dpkg<=
br>
and reinstalled it as follows:<br>
sudo apt-get install lttng-tools lttng-modules-dkms babeltrace<br>
<br>
The ppa in the system is: <a href=3D"http://ppa.launchpad.net/lttng/ppa/ubu=
ntu" target=3D"_blank">http://ppa.launchpad.net/<u></u>lttng/ppa/ubuntu</a>=
<br>
<br>
Now, I get the following error:<br>
sudo lttng list -k<br>
Error: Unable to list kernel events: Kernel tracer not available<br>
Error: Command error<br>
<br>
I have encountered this problem on two different systems running Ubuntu<br>
12.04, after the update of system and LTTng<br>
<br>
Regards,<br>
Shariyar<br>
<br>
<br>
On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel &lt;<a href=3D"mailto:Dan=
iel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.g=
c.<u></u>ca</a>&gt; wrote:<br>
<br>
<br>
=C2=A0 ------------------------------<u></u>------------------------------<=
u></u>----------<br>
Date: Sun, 6 Jul 2014 18:49:51 -0400<br></div></div>
From: Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com" target=3D"_bl=
ank">syed.shariyar@gmail.com</a>&gt; &lt;<a href=3D"mailto:syed.shariyar@gm=
ail.com" target=3D"_blank">syed.shariyar@gmail.com</a>&gt;<div class=3D""><=
br>
<br>
=C2=A0 I am having a problem in generating a kernel trace using the latest<=
br>
<br>
=C2=A0 LTTng on Ubuntu 12.04.<br>
<br>
=C2=A0 It was working fine previously but when I updated LTTng it stopped<b=
r>
<br>
=C2=A0 generating the trace contents. I did an uninstall and reinstall but =
it<br>
didn&#39;t work either.<br>
------------------------------<u></u>------------------------------<u></u>-=
---------<br>
<br>
=C2=A0 =C2=A0 Please define what you mean by &quot;the latest LTTng&quot;. =
=C2=A0What are the<br>
versions? =C2=A0($ lttng --version, $ lttng-sessiond --version)<br>
<br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp;<br>
Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical<br>
Cyber Security (MCCS)<br>
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research<br>
Centre<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC =C2=A0G3J 1X5<br>
CANADA<br>
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000" t=
arget=3D"_blank">(418) 844-4000 x4245</a><br>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538" target=3D=
"_blank">(418) 844-4538</a><br></div>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.<u></u>asp?addr=3D9=
18V%20QSDJ</a>&gt; &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D9=
18V%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.<u></u>asp?addr=
=3D918V%20QSDJ</a>&gt;<br>

Gouvernement du Canada | Government of Canada&lt;<a href=3D"http://www.valc=
artier.drdc-rddc.gc.ca/" target=3D"_blank">http://www.valcartier.<u></u>drd=
c-rddc.gc.ca/</a>&gt; &lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/=
" target=3D"_blank">http://www.valcartier.drdc-<u></u>rddc.gc.ca/</a>&gt;<d=
iv class=3D"">
<br>
<br>
<br>
<br>
______________________________<u></u>_________________<br>
lttng-dev mailing listlttng-dev@lists.lttng.<u></u>orghttp://<a href=3D"htt=
p://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">l=
ists.lttng.org/cgi-<u></u>bin/mailman/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
</div></blockquote></blockquote>
<br>
</blockquote></div><br></div>

--047d7b6d8244cc6ac304fd9e892d--


--===============1948827505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1948827505==--
