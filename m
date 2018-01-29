From: Genevieve Bastien <gbastien+lttng@versatic.net>
Subject: RFC: lttng-module: how to track the link between host
 and guest traces
Date: Mon, 29 Jan 2018 11:32:17 -0500
Message-ID: <ff5d6971-7718-db16-08fc-f561bf2ec6de__34421.8656923205$1519120683$gmane$org@versatic.net>
References: <20180126140348.GA17788@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5667377700833213362=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 3zVbFj2LYZzC3h
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jan 2018 16:54:16 +0000 (UTC)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.89)
 (envelope-from <gbastien+lttng@versatic.net>) id 1egCLx-000qu6-Ia
 for lttng-dev@lists.lttng.org; Mon, 29 Jan 2018 11:32:17 -0500
Received: from station16.dorsal.polymtl.ca ([132.207.72.9]:59840)
 by s056.panelboxmanager.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 (envelope-from <gbastien+lttng@versatic.net>) id 1egCLx-000qtx-C6
 for lttng-dev@lists.lttng.org; Mon, 29 Jan 2018 11:32:17 -0500
In-Reply-To: <20180126140348.GA17788@stefanha-x1.localdomain>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============5667377700833213362==
Content-Type: multipart/alternative;
 boundary="------------1FB8503514414A509AF035DB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1FB8503514414A509AF035DB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi all,


Here included is a conversation I had on the kvm mailing list regarding
how to link traces from host and guests when tracing virtual
environments. Following Stefan's last suggestions, here is a suggestion
on what can be done in lttng-modules, it's not intrusive and does not
require modifications to the kernel. Let me know what you think:


* If we want to trace guests _and_ host and linek them together, we
require to set the VM's -uuid parameter. I think virsh does that by
default anyway.

    - We can then obtain this uuid in lttng via
dmi_get_system_info(DMI_PRODUCT_UUID). We can add it to a statedump
event, or in the 'env' section of the metadata (which might be easier to
manager and does not require activating an additional event).

* Guest statedump: on host, we can access the guests by parsing the
struct dentry* kvm_debugfs_dir for entries with the <pid>-xx format. We
can then parse the /proc/<pid>/cmdline to obtain the uuid and associate
it to the guest.

* Guest lifetime during the trace: We can add a lttng-module that adds a
udev rule to intercept VM creation/destruction. We can trace those
events, adding the pid/uuid in the fields.


What do you think of this approach?


Thanks,

Geneviève



-------- Forwarded Message --------
Subject: 	Re: Shared value between host and guests
Date: 	Fri, 26 Jan 2018 14:03:48 +0000
From: 	Stefan Hajnoczi <stefanha@gmail.com>
To: 	Geneviève Bastien <gbastien@versatic.net>
CC: 	kvm@vger.kernel.org



On Thu, Jan 25, 2018 at 10:44:12AM -0500, Geneviève Bastien wrote:
> On 2018-01-25 04:29 AM, Stefan Hajnoczi wrote:
> > On Wed, Jan 24, 2018 at 10:56:26AM -0500, Geneviève Bastien wrote:
> >> Thanks for the hint, I didn't know about those. But the uevents are only
> >> for the host right? There is no specific value in debugfs for guest.
> > I'm not sure I understand the question.
> >
> > Uevent are emitted on the host.  Given the PID field, it should be
> > possible to correlate them to a specific guest (e.g. by looking at
> > information from the user or VM management tools, or simply by looking
> > at /proc/$PID/cmdline for the QEMU -name argument that can be used to
> > identify guests on the host side).
> >
> > Stefan
> With the information from the host and those uevents, we can indeed
> easily figure out in our traces which processes are associated with a
> guest and get its command line and a lot more information.
> 
> The missing piece is in the guest trace. For example, we have lttng
> traces taken on the guest and the host. We may have multiple guests and
> multiple hosts to trace. It's easy to know which traces are from hosts
> from the events, but which are from guests? And which guest trace goes
> with which of the kvm processes on which host? The guest trace contains
> no information that can be linked to the host.
> 
> I was thinking that the guest could do a hypercall to the host after
> bootup to share some unique information, for instance its bootid, that
> the host could store somewhere. That information would be available in
> the traces so that we can easily associate the guest with its host
> process and the states of its virtual CPUs to that of the corresponding
> threads, and much more.
> 
> I hope this describes our need a little better.

The QEMU -uuid <uuid> option makes a UUID available to the guest via
SMBIOS and fw_cfg on x86.  Inside the guest you can print it like this:

  # dmidecode -s system-uuid
  01020304-0506-0708-090A-0B0C0D0E0F10

Maybe you can base the guest trace filename off the UUID:

  guest-01020304-0506-0708-090A-0B0C0D0E0F10-trace-001.dat

On the host you can either find the UUIDs in the libvirt domain XML:

  # virsh dump my-domain
  <domain ...>
    <uuid>0102030405060708090a0b0c0d0e0f10</uuid>
    ...

Or you can use the kvm.ko uevent to find the QEMU PID and then check
/proc/$PID/cmdline for the uuid.  The UUID can also be fetched via the
query-uuid QMP command if you don't want to search /proc/$PID/cmdline
for -uuid <uuid>.

Maybe you can base the host trace filename off the UUID too:

  host-01020304-0506-0708-090A-0B0C0D0E0F10-trace-001.dat

Then the ask of correlating traces becomes pretty easy for
post-processing scripts since they can look at the filenames.

Stefan


--------------1FB8503514414A509AF035DB
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi all,</p>
    <p><br>
    </p>
    <p>Here included is a conversation I had on the kvm mailing list
      regarding how to link traces from host and guests when tracing
      virtual environments. Following Stefan's last suggestions, here is
      a suggestion on what can be done in lttng-modules, it's not
      intrusive and does not require modifications to the kernel. Let me
      know what you think:</p>
    <p><br>
    </p>
    <p>* If we want to trace guests _and_ host and linek them together,
      we require to set the VM's -uuid parameter. I think virsh does
      that by default anyway.</p>
    <p>    - We can then obtain this uuid in lttng via
      dmi_get_system_info(DMI_PRODUCT_UUID). We can add it to a
      statedump event, or in the 'env' section of the metadata (which
      might be easier to manager and does not require activating an
      additional event).</p>
    <p>* Guest statedump: on host, we can access the guests by parsing
      the struct dentry* kvm_debugfs_dir for entries with the
      &lt;pid&gt;-xx format. We can then parse the
      /proc/&lt;pid&gt;/cmdline to obtain the uuid and associate it to
      the guest.</p>
    <p>* Guest lifetime during the trace: We can add a lttng-module that
      adds a udev rule to intercept VM creation/destruction. We can
      trace those events, adding the pid/uuid in the fields.</p>
    <p><br>
    </p>
    <p>What do you think of this approach?</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Geneviève<br>
    </p>
    <br>
    <div class="moz-forward-container"><br>
      -------- Forwarded Message --------
      <table class="moz-email-headers-table" border="0" cellspacing="0"
        cellpadding="0">
        <tbody>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">Subject:
            </th>
            <td>Re: Shared value between host and guests</td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">Date: </th>
            <td>Fri, 26 Jan 2018 14:03:48 +0000</td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">From: </th>
            <td>Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@gmail.com">&lt;stefanha@gmail.com&gt;</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">To: </th>
            <td>Geneviève Bastien <a class="moz-txt-link-rfc2396E" href="mailto:gbastien@versatic.net">&lt;gbastien@versatic.net&gt;</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" align="RIGHT" nowrap="nowrap">CC: </th>
            <td><a class="moz-txt-link-abbreviated" href="mailto:kvm@vger.kernel.org">kvm@vger.kernel.org</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>On Thu, Jan 25, 2018 at 10:44:12AM -0500, Geneviève Bastien wrote:
&gt; On 2018-01-25 04:29 AM, Stefan Hajnoczi wrote:
&gt; &gt; On Wed, Jan 24, 2018 at 10:56:26AM -0500, Geneviève Bastien wrote:
&gt; &gt;&gt; Thanks for the hint, I didn't know about those. But the uevents are only
&gt; &gt;&gt; for the host right? There is no specific value in debugfs for guest.
&gt; &gt; I'm not sure I understand the question.
&gt; &gt;
&gt; &gt; Uevent are emitted on the host.  Given the PID field, it should be
&gt; &gt; possible to correlate them to a specific guest (e.g. by looking at
&gt; &gt; information from the user or VM management tools, or simply by looking
&gt; &gt; at /proc/$PID/cmdline for the QEMU -name argument that can be used to
&gt; &gt; identify guests on the host side).
&gt; &gt;
&gt; &gt; Stefan
&gt; With the information from the host and those uevents, we can indeed
&gt; easily figure out in our traces which processes are associated with a
&gt; guest and get its command line and a lot more information.
&gt; 
&gt; The missing piece is in the guest trace. For example, we have lttng
&gt; traces taken on the guest and the host. We may have multiple guests and
&gt; multiple hosts to trace. It's easy to know which traces are from hosts
&gt; from the events, but which are from guests? And which guest trace goes
&gt; with which of the kvm processes on which host? The guest trace contains
&gt; no information that can be linked to the host.
&gt; 
&gt; I was thinking that the guest could do a hypercall to the host after
&gt; bootup to share some unique information, for instance its bootid, that
&gt; the host could store somewhere. That information would be available in
&gt; the traces so that we can easily associate the guest with its host
&gt; process and the states of its virtual CPUs to that of the corresponding
&gt; threads, and much more.
&gt; 
&gt; I hope this describes our need a little better.

The QEMU -uuid &lt;uuid&gt; option makes a UUID available to the guest via
SMBIOS and fw_cfg on x86.  Inside the guest you can print it like this:

  # dmidecode -s system-uuid
  01020304-0506-0708-090A-0B0C0D0E0F10

Maybe you can base the guest trace filename off the UUID:

  guest-01020304-0506-0708-090A-0B0C0D0E0F10-trace-001.dat

On the host you can either find the UUIDs in the libvirt domain XML:

  # virsh dump my-domain
  &lt;domain ...&gt;
    &lt;uuid&gt;0102030405060708090a0b0c0d0e0f10&lt;/uuid&gt;
    ...

Or you can use the kvm.ko uevent to find the QEMU PID and then check
/proc/$PID/cmdline for the uuid.  The UUID can also be fetched via the
query-uuid QMP command if you don't want to search /proc/$PID/cmdline
for -uuid &lt;uuid&gt;.

Maybe you can base the host trace filename off the UUID too:

  host-01020304-0506-0708-090A-0B0C0D0E0F10-trace-001.dat

Then the ask of correlating traces becomes pretty easy for
post-processing scripts since they can look at the filenames.

Stefan

</pre>
    </div>
  </body>
</html>

--------------1FB8503514414A509AF035DB--

--===============5667377700833213362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5667377700833213362==--
