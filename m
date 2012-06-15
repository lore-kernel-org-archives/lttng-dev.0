From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: lttng - ubuntu 11.10 - problem
Date: Fri, 15 Jun 2012 09:51:29 -0400
Message-ID: <4FDB3DE1.70409__15038.5387162261$1339768330$gmane$org@ericsson.com>
References: <1339746088.90723.YahooMailNeo@web161201.mail.bf1.yahoo.com>
	<4FDAEF5C.9030102@gmail.com> <4FDB34C8.7000505@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1SfWwA-0000rS-RG
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 09:51:42 -0400
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q5FDpZAP023238
	for <lttng-dev@lists.lttng.org>; Fri, 15 Jun 2012 08:51:36 -0500
In-Reply-To: <4FDB34C8.7000505@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

After, check that your session daemon is loaded too.
the following commands should return +- the following:
lsmod |grep lttng

lttng_probe_timer      15523  0
lttng_probe_statedump    15004  0
lttng_probe_signal     13567  0
lttng_probe_sched      16688  0
lttng_probe_kvm        16020  0
lttng_probe_irq        13728  0
lttng_probe_block      16630  0
lttng_types            12508  0
lttng_probe_lttng      12828  0
lttng_ring_buffer_metadata_mmap_client    13369  0
lttng_ring_buffer_client_mmap_overwrite    17622  0
lttng_ring_buffer_client_mmap_discard    17622  0
lttng_ring_buffer_metadata_client    13369  0
lttng_ring_buffer_client_overwrite    17622  0
lttng_ring_buffer_client_discard    17622  0
lttng_tracer          240715  14
lttng_probe_timer,lttng_probe_statedump,lttng_probe_signal,lttng_probe_sche=
d,lttng_probe_kvm,lttng_probe_irq,lttng_probe_block,lttng_probe_lttng,lttng=
_ring_buffer_metadata_mmap_client,lttng_ring_buffer_client_mmap_overwrite,l=
ttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_metadata_client,lttn=
g_ring_buffer_client_overwrite,lttng_ring_buffer_client_discard
lttng_kretprobes       13278  1 lttng_tracer
lttng_kprobes          12971  1 lttng_tracer
lttng_ftrace           13162  1 lttng_tracer
lttng_statedump        13903  1 lttng_tracer
lttng_lib_ring_buffer    46389  7
lttng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_client_mmap_overwr=
ite,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_metadata_client=
,lttng_ring_buffer_client_overwrite,lttng_ring_buffer_client_discard,lttng_=
tracer

ps -aux |grep "ltt"

root      1123  0.0  0.0  47008   728 ?        Ssl  Jun14   0:00
lttng-sessiond

Hope this helps.
Matthew


On 12-06-15 09:12 AM, David Goulet wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
> In order to trace the kernel, you need the LTTng kernel modules available=
 in
> the package "lttng-modules-dkms". So make sure you have these three packa=
ges
> installed:
>
> # sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
>
> The error message you got indicates that there is simply no LTTng modules
> loaded. Please make sure they are loaded and if the problem persist, let =
us know!
>
> Thanks!
> David
>
> On 15/06/12 04:16 AM, Francis Giraldeau wrote:
>> Le 2012-06-15 09:41, somanath sahoo a =E9crit :
>>> Hi,
>>>
>>> As i am new to lttng usage, I have followed the instructions from =

>>> <https://launchpad.net/~lttng/+archive/ppa> in order to install the ltt=
ng
>>> tool set in my ubuntu 11.10. After successful installation, i followed
>>> the getting started link on lttng.org <http://lttng.org/quickstart> in
>>> "root mode".
>> You may verify if kernel modules are loaded correctly. If not, then there
>> may be a problem while the installation.
>>
>> lsmod | grep lttng
>>
>> If not, you may try to load them and see if any error message occurs:
>>
>> sudo modprobe lttng_tracer
>>
>> Francis
>>
>>
>>
>> _______________________________________________ lttng-dev mailing list =

>> lttng-dev@lists.lttng.org =

>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
>
> iQEcBAEBAgAGBQJP2zTIAAoJEELoaioR9I02CVEH/1ripsIVxDQ2JRPNXs0TVWLD
> 5B/qf3oKTohuKCoKE7Q7ZLyo1A9WN0z9JFouVecEPD7MisdJqYufEXkUNbxHg2+y
> 9nVT8xF7gToLRBi/qC/hH0JN6AADJmqTVxYAvygv8qWNkLR3PSqguDhE5nM9vrtF
> LJSEYlYQh0dktkBM9ESm0lrnbZO/AtXxQB4IbCQSwP1tsNmftEdZ24H8DN0/QWl9
> niRT6XpBzogNJfQQOPFtJTFxpwKHiMQXdE78UtzzMBPZ9P57Go9jMgP+2FELFZl4
> wcu+XMIF2Gx81AajfTkGAjPOczagqKzrgnMCduQaNgCI1hRoWOn7Yu1jTmA6Yxc=3D
> =3Doy1n
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
