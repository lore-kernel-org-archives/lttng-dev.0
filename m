From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH v3 lttng-tools] Filter allocation and large
 bytecode fixes
Date: Fri, 07 Sep 2012 13:37:14 -0400
Message-ID: <504A30CA.7020209__23009.8525564701$1347039477$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
	<1346953219-9001-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TA2UZ-0000zE-Gl
	for lttng-dev@lists.lttng.org; Fri, 07 Sep 2012 13:37:19 -0400
In-Reply-To: <1346953219-9001-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Merged!

Christian Babeux:
> Previous iteration of patch 2/3 was missing a typo fix in the 
> LTTNG_FILTER_MAX_LEN define.
> 
> Also, Mathieu suggested that we put a check on the
> reloc_table_offset in the sessiond to check its bounds when
> receiving the LTTNG_SET_FILTER command. This is not necessary
> because the reloc_table_offset does not exist in the filter struct
> of the lttcomm_session_msg union.
> 
> Changelog v3:
> 
> 1/3 - Already merged. 2/3 - Add missing typo fix in
> LTTNG_FILTER_MAX_LEN define. 3/3 - Already merged.
> 
> Changelog v2:
> 
> 1/3 - Already merged. 2/3 - Respin. Support 65536 bytes bytecode
> len + filter ABI changes. 3/3 - Already merged.
> 
> Thanks,
> 
> Christian Babeux (1): Fix: Accept bytecode of length 65536 bytes
> 
> src/bin/lttng-sessiond/lttng-ust-abi.h                      | 6
> +++--- src/bin/lttng-sessiond/main.c
> | 2 +- src/common/sessiond-comm/sessiond-comm.h
> | 6 +++--- 
> src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c | 2 +- 
> 4 files changed, 8 insertions(+), 8 deletions(-)
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQSjDAAAoJEELoaioR9I02atsIAIQtPFOgFQrc4akLIbZTqIOi
AjdzJXkD8HPd4tpYdmLfSLZWi/Ia4rwl2quhWv/+PHOrt5ykBzBApTpjYGzc86oL
2m5ucrK4BFT9sMKU/hLm5eJ2+KVMjTL31Ek9LRt96YmmF2a2QMk/vfAEAJ6VA8XT
3IVfnT9bDNMn/WdwZRP5Dseob38xlumTMN4x/giz4BxBZDM8T4LV+fziFNSdwDvv
ZWros1eSeznUU3uCZ1/85YqYb/CK09LbDv0bD5e+Hv9t4j/WadwyVV/BAuBOh+9m
zBdoZtoxx+Fx6jrGJCNtyeV4/cEDNHfyaVW51ZAyaW4yS7yygQmlvIbs0OJ/SMc=
=F7Wm
-----END PGP SIGNATURE-----
