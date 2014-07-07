From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: LTTng not generating trace contents
Date: Mon, 7 Jul 2014 14:11:46 -0400
Message-ID: <CAKQh6ph1Ck-aR0PJ_YZoFxF9R1gogh4xGORaoCWDiH55QcxTkg__48982.7937134125$1404756778$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C729D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAKQh6pjJ9SUFKtLwONVySiPbtP-udZCfs9L87mGszPVPCu2PKA@mail.gmail.com>
 <53BAE112.4000809@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2034026692=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1X4DOK-0000zT-Ic
 for lttng-dev@lists.lttng.org; Mon, 07 Jul 2014 14:11:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so5869122pac.11
 for <lttng-dev@lists.lttng.org>; Mon, 07 Jul 2014 11:11:46 -0700 (PDT)
In-Reply-To: <53BAE112.4000809@voxpopuli.im>
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

--===============2034026692==
Content-Type: multipart/alternative; boundary=047d7b6d824480ab3a04fd9e6877

--047d7b6d824480ab3a04fd9e6877
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

No it didn't install correctly.It is generating a crash report and
lttng-module-dkms exists in it too.


Regards,
Shariyar


On Mon, Jul 7, 2014 at 2:04 PM, Alexandre Montplaisir <
alexmonthy@voxpopuli.im> wrote:

>  Hi,
>
> Could you just do
> $ sudo apt-get install --reinstall lttng-modules-dkms
>
> and check in the output if you have any errors, or if it really installs
> successfully?
>
> Maybe Ubuntu's patches already trickled down to 12.04 and you might be
> hitting https://bugs.lttng.org/issues/814
>
>
> Thanks,
> Alexandre
>
>
>
> On 07/07/2014 01:43 PM, Shariyar wrote:
>
>  lttng --version,
>     lttng (LTTng Trace Control) 2.4.1 - =C3=89poque Opaque
>
>  lttng-sessiond --version
>     2.4.1
>
>
> I removed all LTTng packages from the system by manually searching in dpk=
g
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
> On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel <Daniel.Thibault@drdc-r=
ddc.gc.ca> wrote:
>
>
>  ----------------------------------------------------------------------
> Date: Sun, 6 Jul 2014 18:49:51 -0400
> From: Shariyar <syed.shariyar@gmail.com> <syed.shariyar@gmail.com>
>
>  I am having a problem in generating a kernel trace using the latest
>
>  LTTng on Ubuntu 12.04.
>
>  It was working fine previously but when I updated LTTng it stopped
>
>  generating the trace contents. I did an uninstall and reinstall but it
> didn't work either.
> ----------------------------------------------------------------------
>
>    Please define what you mean by "the latest LTTng".  What are the
> versions?  ($ lttng --version, $ lttng-sessiond --version)
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <ht=
tp://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada<http://www.valcartier.drdc-=
rddc.gc.ca/> <http://www.valcartier.drdc-rddc.gc.ca/>
>
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev
>
>
>

--047d7b6d824480ab3a04fd9e6877
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No it didn&#39;t install correctly.It is generating a cras=
h report and lttng-module-dkms exists in it too.<div>=C2=A0<div><br></div><=
div>Regards,</div><div>Shariyar</div></div></div><div class=3D"gmail_extra"=
><br><br>
<div class=3D"gmail_quote">On Mon, Jul 7, 2014 at 2:04 PM, Alexandre Montpl=
aisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpopuli.im" targ=
et=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">

 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi,<br>
    <br>
    Could you just do<br>
    $ sudo apt-get install --reinstall lttng-modules-dkms<br>
    <br>
    and check in the output if you have any errors, or if it really
    installs successfully?<br>
    <br>
    Maybe Ubuntu&#39;s patches already trickled down to 12.04 and you might
    be hitting <a href=3D"https://bugs.lttng.org/issues/814" target=3D"_bla=
nk">https://bugs.lttng.org/issues/814</a><br>
    <br>
    <br>
    Thanks,<br>
    Alexandre<div><div class=3D"h5"><br>
    <br>
    <br>
    <div>On 07/07/2014 01:43 PM, Shariyar wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">
      <pre> lttng --version,
    lttng (LTTng Trace Control) 2.4.1 - =C3=89poque Opaque

 lttng-sessiond --version
    2.4.1


I removed all LTTng packages from the system by manually searching in dpkg
and reinstalled it as follows:
sudo apt-get install lttng-tools lttng-modules-dkms babeltrace

The ppa in the system is: <a href=3D"http://ppa.launchpad.net/lttng/ppa/ubu=
ntu" target=3D"_blank">http://ppa.launchpad.net/lttng/ppa/ubuntu</a>

Now, I get the following error:
sudo lttng list -k
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

I have encountered this problem on two different systems running Ubuntu
12.04, after the update of system and LTTng

Regards,
Shariyar


On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel &lt;
<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel=
.Thibault@drdc-rddc.gc.ca</a>&gt; wrote:

</pre>
      <blockquote type=3D"cite">
        <pre>--------------------------------------------------------------=
--------
Date: Sun, 6 Jul 2014 18:49:51 -0400
From: Shariyar <a href=3D"mailto:syed.shariyar@gmail.com" target=3D"_blank"=
>&lt;syed.shariyar@gmail.com&gt;</a>

</pre>
        <blockquote type=3D"cite">
          <pre>I am having a problem in generating a kernel trace using the=
 latest
</pre>
        </blockquote>
        <pre>LTTng on Ubuntu 12.04.
</pre>
        <blockquote type=3D"cite">
          <pre>It was working fine previously but when I updated LTTng it s=
topped
</pre>
        </blockquote>
        <pre>generating the trace contents. I did an uninstall and reinstal=
l but it
didn&#39;t work either.
----------------------------------------------------------------------

   Please define what you mean by &quot;the latest LTTng&quot;.  What are t=
he
versions?  ($ lttng --version, $ lttng-sessiond --version)

Daniel U. Thibault
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp;
Countermeasures (SPC)
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
Centre
2459 route de la Bravoure
Qu=C3=A9bec QC  G3J 1X5
CANADA
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000" t=
arget=3D"_blank">(418) 844-4000 x4245</a>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538" target=3D=
"_blank">(418) 844-4538</a>
NAC : 918V QSDJ <a href=3D"http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ" target=3D"_blank">&lt;http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ&gt;</a>
Gouvernement du Canada | Government of Canada
<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">&lt;ht=
tp://www.valcartier.drdc-rddc.gc.ca/&gt;</a>

</pre>
      </blockquote>
      <pre></pre>
      <br>
      <fieldset></fieldset>
      <br>
      </div></div><div class=3D""><pre>____________________________________=
___________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </div></blockquote>
    <br>
  </div>

</blockquote></div><br></div>

--047d7b6d824480ab3a04fd9e6877--


--===============2034026692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2034026692==--
