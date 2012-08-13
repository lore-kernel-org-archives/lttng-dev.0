From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng: problem with lttng-sessiond.
Date: Mon, 13 Aug 2012 16:51:18 -0400
Message-ID: <502968C6.70301__39894.5983303294$1344891108$gmane$org@efficios.com>
References: <CAGya9Mk5cmdugqkqguS1jUhWw7P-XVz+2S0YWiUys6547J6gyg@mail.gmail.com>
	<20120813132231.GA24219@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1T11bd-0006Mn-JB
	for lttng-dev@lists.lttng.org; Mon, 13 Aug 2012 16:51:21 -0400
In-Reply-To: <20120813132231.GA24219@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Stefan Karlsson S12 <skn07007@student.mdh.se>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Oh my! This is a good one haha!

So, first of all, I think a gdb backtrace would be useful to know
exactly where there is an illegal instruction.

Also, on which arch and OS version are you running this.

Thanks!
David

Mathieu Desnoyers:
> CCing David Goulet, maintainer of lttng-tools. He will look into
> your issue.
> 
> Thanks,
> 
> Mathieu
> 
> * Henrik Hautakoski (henrik@fiktivkod.org) wrote:
>> Hi, We have some problems with spawning a session daemon. running
>> the command "lttng-sessiond --vvv --no-kernel" and get "Illegal
>> instruction" See output:
>> 
>> DEBUG3: Creating LTTng run directory: /var/run/lttng [in 
>> create_lttng_rundir() at main.c:5323] DEBUG2: Kernel consumer err
>> path: /var/run/lttng/kconsumerd/error [in main() at main.c:5571] 
>> DEBUG2: Kernel consumer cmd path:
>> /var/run/lttng/kconsumerd/command [in main() at main.c:5573] 
>> DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond
>> [in main() at main.c:5626] DEBUG1: Application socket path
>> /var/run/lttng/apps-lttng-sessiond [in main() at main.c:5627] 
>> DEBUG1: LTTng run directory path: /var/run/lttng [in main() at
>> main.c:5628] DEBUG2: UST consumer 32 bits err path: 
>> /var/run/lttng/ustconsumerd32/error [in main() at main.c:5637] 
>> DEBUG2: UST consumer 32 bits cmd path: 
>> /var/run/lttng/ustconsumerd32/command [in main() at main.c:5639] 
>> DEBUG2: UST consumer 64 bits err path: 
>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:5648] 
>> DEBUG2: UST consumer 64 bits cmd path: 
>> /var/run/lttng/ustconsumerd64/command [in main() at main.c:5650] 
>> DEBUG3: Created hashtable size 4 at 0x10064080 of type 1 [in 
>> lttng_ht_new() at hashtable.c:96] DEBUG3: Created hashtable size
>> 4 at 0x10064168 of type 1 [in lttng_ht_new() at hashtable.c:96] 
>> DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd
>> [in set_consumer_sockets() at main.c:5365] DEBUG2: Creating
>> consumer directory: /var/run/lttng/ustconsumerd64 [in 
>> set_consumer_sockets() at main.c:5365] DEBUG2: Creating consumer
>> directory: /var/run/lttng/ustconsumerd32 [in 
>> set_consumer_sockets() at main.c:5365] DEBUG1: Signal handler set
>> for SIGTERM, SIGPIPE and SIGINT [in set_signal_handler() at
>> main.c:5457] DEBUG1: All permissions are set [in
>> set_permissions() at main.c:5310] DEBUG1: epoll set max size is
>> 180337 [in compat_epoll_set_max_size() at compat-epoll.c:224] 
>> Illegal instruction
>> 
>> What to do? :P
>> 
>> -- Henrik Hautakoski henrik@fiktivkod.org
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQKWjDAAoJEELoaioR9I02VdsIAIlyG8BFbTPZDgHpxynWUD6i
0Uh4N4TTQgxRQ3WnbSWMOnx1l2qxG9XbJ9wwvrjJvnH2UCBcQ2g8vl2BQiaMN0BI
ZwD2/UDLRioP8BLv5y/5zAAoU6MSVz+ZCbLOI/oTHDcYzA5TdXmzpcW+XS7rKxHd
uRyUmGsRdxViOZ3JA7vCEZR/ea02p17PzFrq+/bn/mE2L07ZrKN7TLdpmTlMyPP/
KmaRBcQUZkwrQ+0wqkgj6pkDPjLfLt8/au3v6x+iPvi09bHlHF9nB5wCve3g1UpZ
NNvz07XPtgnSa6quM3LXqdIp02Zrvr2xx/eL7i2ZoReWtjnNnYcHCWZQvfdsjkY=
=1ekn
-----END PGP SIGNATURE-----
