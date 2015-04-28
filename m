From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Mon, 27 Apr 2015 22:00:54 -0400 (EDT)
Message-ID: <574727031.14339994.1430186454057.JavaMail.zimbra__5369.41426476023$1430186514$gmane$org@polymtl.ca>
References: <1024078202.13732013.1430137815501.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0368616696=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1YmupV-0006Wa-Rq
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 22:00:58 -0400
In-Reply-To: <1024078202.13732013.1430137815501.JavaMail.zimbra@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: machinekit@googlegroups.com
Cc: =?utf-8?Q?Rafa=C3=ABl?= Blanchet-Lecomte <rafael.blanchet-lecomte@polymtl.ca>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0368616696==
Content-Type: multipart/alternative;
	boundary="----=_Part_14339993_152467586.1430186454056"

------=_Part_14339993_152467586.1430186454056
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


> That said, the folks which have timing problems have not caught on yet.. it 
> looks some more guidance, examples and a bit of a machinekit-specific 
> writeup is needed, competing with the other 247 priority projects on my desk 
> ;) 

Many people interested in MachineKit wonder about the control platform to select, from the most inexpensive (Raspberry PI) with more latency issues to the more expensive (Intel with FPGA card), with many interesting alternatives in between. The big question is always the real-time response for a typical challenging target such as 5 axis servo + spindle (3 phase variable frequency). We have the ability with LTTng to diagnose such real-time problems and thus to properly tune and then evaluate these different solutions. At the same time, it provides a challenging testbed for the LTTng toolchain. Your comments and suggestions on the hardware setup to test are most welcome! 

Here is my current list of popular and interesting hardware that we would like to try out and properly assess this Summer: 

- Raspberry PI 2, low end and most inexpensive. 

- BeagleBone Black and eventually BeagleBoard X15, slightly more expensive but very interesting for control applications with PRUs, PWM and eQEP. 

- Combined ARM and FPGA with Xilinx chips like Zedboards. The Adapteva Parallela board comes with a Xilinx Z-7010 or Z-7020. You get a dual-core A9, and FPGA for custom logic for encoder inputs and PWM or step generation. 

- Intel board (Atom or better, suggestions for model welcome) with parallel port I/O or any of the available FPGA I/O cards. 

Indeed, while some of the platforms may work without additional hardware (BeagleBone or Zedboard), an FPGA board provides a robust and high performance solution. I have a MesaNet 5I20 but the PCI bus is becoming legacy. Many newer models are offered using high speed data connections which are very convenient but not normally relied upon for real-time work (USB and Ethernet). However, given their high speed and with a dedicated link, it may be workable. Again an excellent testbed for the LTTng toolchain and some hardware measurements. We could test: 

- Mesanet 6I24 FPGA PCIe card with 72 GPIO (baseline for low latency) 

- Mesanet 7I80HD FPGA Ethernet with 72GPIO 

- Mesanet 7I61 FPGA USB with 96 GPIO 


------=_Part_14339993_152467586.1430186454056
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br>&gt; That said, the folks wh=
ich have timing problems have not caught on yet.. it<br>&gt; looks some mor=
e guidance, examples and a bit of a machinekit-specific<br>&gt; writeup is =
needed, competing with the other 247 priority projects on my desk<br>&gt; ;=
)<br></div><div><br></div><div>Many people interested in MachineKit wonder =
about the control platform to select, from the most inexpensive (Raspberry =
PI) with more latency issues to the more expensive (Intel with FPGA card), =
with many interesting alternatives in between. The big question is always t=
he real-time response for a typical challenging target such as 5 axis servo=
 + spindle (3 phase variable frequency). We have the ability with LTTng to =
diagnose such real-time problems and thus to properly tune and then evaluat=
e these different solutions. At the same time, it provides a challenging te=
stbed for the LTTng toolchain. Your comments and suggestions on the hardwar=
e setup to test are most welcome!</div><div><br></div><div>Here is my curre=
nt list of popular and interesting hardware that we would like to try out a=
nd properly assess this Summer:</div><div><br></div><div>- Raspberry PI 2, =
low end and most inexpensive.</div><div><br></div><div>- BeagleBone Black a=
nd eventually BeagleBoard X15, slightly more expensive but very interesting=
 for control applications with PRUs, PWM and eQEP.</div><div><br></div><div=
>- Combined ARM and FPGA with Xilinx chips like Zedboards. The Adapteva Par=
allela board comes with a Xilinx Z-7010 or Z-7020. You get a dual-core A9, =
and FPGA for custom logic for encoder inputs and PWM or step generation.</d=
iv><div><br></div><div>- Intel board (Atom or better, suggestions for model=
 welcome) with parallel port I/O or any of the available FPGA I/O cards.</d=
iv><div><br></div><div>Indeed, while some of the platforms may work without=
 additional hardware (BeagleBone or Zedboard), an FPGA board provides a rob=
ust and high performance solution. I have a MesaNet 5I20 but the PCI bus is=
 becoming legacy. Many newer models are offered using high speed data conne=
ctions which are very convenient but not normally relied upon for real-time=
 work (USB and Ethernet). However, given their high speed and with a dedica=
ted link, it may be workable. Again an excellent testbed for the LTTng tool=
chain and some hardware measurements. We could test:</div><div><br></div><d=
iv>- Mesanet 6I24 FPGA PCIe card with 72 GPIO (baseline for low latency)</d=
iv><div><br></div><div>- Mesanet &nbsp;7I80HD FPGA Ethernet with 72GPIO</di=
v><div><br></div><div>- Mesanet 7I61 FPGA USB with 96 GPIO</div><div><br></=
div></div></body></html>
------=_Part_14339993_152467586.1430186454056--


--===============0368616696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0368616696==--
