From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: Timestamps in babeltrace
Date: Thu, 06 Sep 2012 15:42:43 +0200
Message-ID: <5048A853.2070701__8335.71958723969$1346939009$gmane$org@keymile.com>
References: <4EEB1A44.2020500@keymile.com> <503CC0DF.7030607@keymile.com>
	<503E3297.8090703@keymile.com> <20120906133819.GB3630@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.ch.keymile.com ([193.17.201.103])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Gerlando.Falauto@keymile.com>) id 1T9cM9-0004we-9S
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 09:42:53 -0400
In-Reply-To: <20120906133819.GB3630@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

thanks for your answer.
Actually I already found a solution and posted a patch to the list...
didn't you see that?

As for whatever junk I see on TMF, well... that's a problem within TMS!
So I am crying for help on their list about that. :-)

Thanks,
Gerlando

On 09/06/2012 03:38 PM, Mathieu Desnoyers wrote:
> Hello!
>
> We use the kernel clock gettime (see
> lttng-modules/wrapper/trace-clock.h). Currently we use ktime_get(), but
> I think I need to fix that for archs where it does not return
> nanoseconds, but I doubt this would be causing your issue. What we _do_
> expect though is that ktime_get returns a monotonic time from a CPU
> point of view. If your time source ever goes backward, this would be
> seen as an overflow.
>
> You might want to triple-check that your time source never go backward.
>
> Mathieu
>
> * Gerlando Falauto (gerlando.falauto@keymile.com) wrote:
>> Hi again,
>>
>> I tested this on an ARM board, and results look OK on both babeltrace
>> and within TMF. So there must be something wrong with the way timestamps
>> are calculated (and/or stored) by LLTng 2.x on the target.
>>
>> I looked at the timestamps again (having babeltrace dump the
>> timestamp-cycles in HEX, sided by timestamp-seconds), and got the
>> following:
>>
>> [000000000e3816c58e6e] [1346144403.557251024]  (+?.?????????)
>> [000000000e3816e58d02] [1346144403.559347812]  (+0.002096788)
>> [000000000e3816e887cb] [1346144403.559543085]  (+0.000195273)
>> [000000000e3816f08eb7] [1346144403.560069145]  (+0.000526060)
>> [000000000e3816f91981] [1346144403.560628963]  (+0.000559818)
>> [000000000e38170a3b65] [1346144403.561751751]  (+0.001122788)
>> [000000000e3817108c1b] [1346144403.562165629]  (+0.000413878)
>> [000000000e381712d427] [1346144403.562315145]  (+0.000149516)
>> [000000000e38172a770d] [1346144403.563864175]  (+0.001549030)
>> [000000000e381744a88b] [1346144403.565580781]  (+0.001716606)
>> [000000000e38176dd2e6] [1346144403.568278600]  (+0.002697819)
>> [000000000e38176f4e65] [1346144403.568375751]  (+0.000097151)
>> [000000000e381779ed61] [1346144403.569071811]  (+0.000696060)
>> [000000000e38177b3f36] [1346144403.569158296]  (+0.000086485)
>> [000000000e38177bc849] [1346144403.569193387]  (+0.000035091)
>> [000000000e38177ce3e7] [1346144403.569265993]  (+0.000072606)
>> [000000000e38177e25a3] [1346144403.569348357]  (+0.000082364)
>> [000000000e38177f214b] [1346144403.569412781]  (+0.000064424)
>> [000000000e3817804754] [1346144403.569488054]  (+0.000075273)
>> [000000000e381793d8cc] [1346144403.570770478]  (+0.001282424)
>> [000000000e3817951f07] [1346144403.570853993]  (+0.000083515)
>> [000000000e38179cc3b5] [1346144403.571354903]  (+0.000500910)
>> [000000000e38179ef04a] [1346144403.571497388]  (+0.000142485)
>> [000000000e3817a066d0] [1346144403.571593266]  (+0.000095878)
>> [000000000e3817a84ab3] [1346144403.572110357]  (+0.000517091)
>> [000000000e3817aaf798] [1346144403.572285690]  (+0.000175333)
>> [000000000e3817acc2a4] [1346144403.572403206]  (+0.000117516)
>> [000000000e3817bc26fb] [1346144403.573411933]  (+0.001008727)
>> [000000000e3817c223e3] [1346144403.573804357]  (+0.000392424)
>> [000000000e3817c3731d] [1346144403.573890175]  (+0.000085818)
>> [000000000e3817c3fb7a] [1346144403.573925084]  (+0.000034909)
>> [000000000e3817c50c71] [1346144403.573994963]  (+0.000069879)
>> [000000000e3817c64a26] [1346144403.574076296]  (+0.000081333)
>> [000000000e3817c74519] [1346144403.574140539]  (+0.000064243)
>> [000000000e3817c8684a] [1346144403.574215084]  (+0.000074545)
>> [000000000e3817d4a27f] [1346144403.575016417]  (+0.000801333)
>> [000000000e3817dbc719] [1346144403.575484539]  (+0.000468122)
>> [000000000e3817de86b2] [1346144403.575664660]  (+0.000180121)
>> [000000000e3817e98332] [1346144403.576384660]  (+0.000720000)
>> [000000000e3817eed6d5] [1346144403.576733751]  (+0.000349091)
>> [000000000e3817f0f079] [1346144403.576871387]  (+0.000137636)
>> [000000000e3817fa997c] [1346144403.577504478]  (+0.000633091)
>> [000000000e3817ffc467] [1346144403.577843145]  (+0.000338667)
>> [000000000e3818100692] [1346144403.578908660]  (+0.001065515)
>> [000000000e381817dcf7] [1346144403.579422297]  (+0.000513637)
>> [000000000e381821774c] [1346144403.580051630]  (+0.000629333)
>> [000000000e3818293e89] [1346144403.580561387]  (+0.000509757)
>> [000000000e38182d7c79] [1346144403.580839387]  (+0.000278000)
>> [000000000e38183661ef] [1346144403.581422417]  (+0.000583030)
>> [000000000e38183d1430] [1346144403.581861266]  (+0.000438849)
>> [000000000e3818433d9a] [1346144403.582265084]  (+0.000403818)
>> [000000000e38184a844a] [1346144403.582741932]  (+0.000476848)
>> [000000000e3818511160] [1346144403.583171266]  (+0.000429334)
>> [000000000e381857ed4b] [1346144403.583620781]  (+0.000449515)
>> [000000000e381861db33] [1346144403.584271509]  (+0.000650728)
>> [000000000e3818678ef3] [1346144403.584645205]  (+0.000373696)
>> [000000000e38186e85dc] [1346144403.585101630]  (+0.000456425)
>> [000000000e381875ec45] [1346144403.585586599]  (+0.000484969)
>> [000000000e38187af334] [1346144403.585916054]  (+0.000329455)
>> [000000000e3818a5f4ac] [1346144403.588734478]  (+0.002818424)
>> [000000000e3818bd10dd] [1346144403.590249023]  (+0.001514545)
>> [000000000e3818c35f73] [1346144403.590662357]  (+0.000413334)
>> [000000000e3818c4c52a] [1346144403.590753932]  (+0.000091575)
>> [000000000e3818cbb849] [1346144403.591209387]  (+0.000455455)
>> [000000000e3818cfcccb] [1346144403.591476781]  (+0.000267394)
>> [000000000e3818d54f12] [1346144403.591837812]  (+0.000361031)
>> [000000000e3818d81053] [1346144403.592018357]  (+0.000180545)
>> [000000000e3818d932cf] [1346144403.592092721]  (+0.000074364)
>> [000000000e3818de4f48] [1346144403.592427690]  (+0.000334969)
>> [000000000e3818df9af5] [1346144403.592512599]  (+0.000084909)
>> [000000000e38191378e5] [1346144403.595911751]  (+0.003399152)
>> [000000000e38191542c1] [1346144403.596028963]  (+0.000117212)
>> [000000000e3819189d6b] [1346144403.596248781]  (+0.000219818)
>> [000000000e38191a4715] [1346144403.596357751]  (+0.000108970)
>> [000000000e3819282a3e] [1346144403.597267872]  (+0.000910121)
>> [000000000e38194e6256] [1346144403.599772600]  (+0.002504728)
>> [000000000e3819516697] [1346144403.599970297]  (+0.000197697)
>> [000000000e381953f0eb] [1346144403.600136781]  (+0.000166484)
>> [000000000e38195791e5] [1346144403.600374599]  (+0.000237818)
>> [000000000e38196bff4c] [1346144403.601713326]  (+0.001338727)
>> [000000000e38196d4459] [1346144403.601796539]  (+0.000083213)
>> [000000000e38197290a5] [1346144403.602143751]  (+0.000347212)
>> [000000000e381975ccc5] [1346144403.602355751]  (+0.000212000)
>> [000000000e381976eac1] [1346144403.602428963]  (+0.000073212)
>> [000000000e38197bf486] [1346144403.602759144]  (+0.000330181)
>> [000000000e38197e224a] [1346144403.602901932]  (+0.000142788)
>> [000000000e38197f2364] [1346144403.602967750]  (+0.000065818)
>> [000000000e381986a674] [1346144403.603460054]  (+0.000492304)
>> [000000000e38198b8fcb] [1346144403.603781933]  (+0.000321879)
>> [000000000e38198cd550] [1346144403.603865266]  (+0.000083333)
>> [000000000e381992f086] [1346144403.604265448]  (+0.000400182)
>> [000000000e3819943d9f] [1346144403.604350721]  (+0.000085273)
>> [000000000e3819b686d8] [1346144403.606597690]  (+0.002246969)
>> [000000000e3819b8259e] [1346144403.606703872]  (+0.000106182)
>> [000000000e3819bb4684] [1346144403.606908902]  (+0.000205030)
>> [000000000e3819ec04bc] [1346144403.610103326]  (+0.003194424)
>> [000000000e3819eda61d] [1346144403.610210175]  (+0.000106849)
>> [000000000e3819f0c77c] [1346144403.610415326]  (+0.000205151)
>> [000000000e381a2178af] [1346144403.613606417]  (+0.003191091)
>> [000000000e381a2314da] [1346144403.613711932]  (+0.000105515)
>> [000000000e381a2633dc] [1346144403.613916478]  (+0.000204546)
>> [000000000e381a4f3892] [1346144403.616604660]  (+0.002688182)
>> [000000000e381a50ca8f] [1346144403.616707569]  (+0.000102909)
>> [000000000e381a53e5c7] [1346144403.616911145]  (+0.000203576)
>> [000000000e381a557437] [1346144403.617013145]  (+0.000102000)
>> [000000000e381a7d5dc8] [1346144403.619628842]  (+0.002615697)
>> [000000000e381a7fa51d] [1346144403.619778175]  (+0.000149333)
>> [000000000e381a864560] [1346144403.620212418]  (+0.000434243)
>> [000000000e381a9651cd] [1346144403.621264175]  (+0.001051757)
>> [000000000e381aa37b5b] [1346144403.622126781]  (+0.000862606)
>> [000000000e381ab84868] [1346144403.623489994]  (+0.001363213)
>> [000000000e381ac23926] [1346144403.624141448]  (+0.000651454)
>> [000000000e381adcda62] [1346144403.625886660]  (+0.001745212)
>> [000000000e381ae50f78] [1346144403.626424538]  (+0.000537878)
>> [000000000e381aebcd52] [1346144403.626866356]  (+0.000441818)
>> [000000000e381aeec673] [1346144403.627061205]  (+0.000194849)
>> [000000000e381b1e47ac] [1346144403.630174478]  (+0.003113273)
>> [000000000e381b33e1bd] [1346144403.631590175]  (+0.001415697)
>> [000000000e381b3a9348] [1346144403.632028842]  (+0.000438667)
>> [000000000e381b636d9d] [1346144403.634706175]  (+0.002677333)
>> [000000000e381b6b6304] [1346144403.635227750]  (+0.000521575)
>> [000000000e381b72078a] [1346144403.635663084]  (+0.000435334)
>> [000000000e381b7426dd] [1346144403.635802175]  (+0.000139091)
>> [000000000e381b7b720d] [1346144403.636280175]  (+0.000478000)
>> [000000000e381b839470] [1346144403.636813266]  (+0.000533091)
>> [000000000e381b85aca9] [1346144403.636950539]  (+0.000137273)
>> [000000000e381b8b5abb] [1346144403.637322781]  (+0.000372242)
>> [000000000e381b9a25e6] [1346144403.638292296]  (+0.000969515)
>> [000000000e381ba522a2] [1346144403.639012356]  (+0.000720060)
>> [000000000e381ba86e62] [1346144403.639228356]  (+0.000216000)
>> [000000000e381bb3f1d5] [1346144403.639982903]  (+0.000754547)
>> [000000000e381bb7c172] [1346144403.640232660]  (+0.000249757)
>> [000000000e3903588b84] [1346144407.526307046]  (+3.886074386)
>> [000000000e390359cae2] [1346144407.526388804]  (+0.000081758)
>> [000000000e39035b5e4b] [1346144407.526492077]  (+0.000103273)
>> [000000000e390d5bcfc7] [1346144407.694293289]  (+0.167801212)
>> [000000000e390d5cfa12] [1346144407.694369652]  (+0.000076363)
>> [000000000e390d5e5b4b] [1346144407.694460077]  (+0.000090425)
>> [000000000e390eca0c68] [1346144407.718294986]  (+0.023834909)
>> [000000000e390ecb3326] [1346144407.718370440]  (+0.000075454)
>> [000000000e390ecc897b] [1346144407.718458077]  (+0.000087637)
>> [000000000e390f9daeac] [1346144407.732164622]  (+0.013706545)
>> [000000000e390f9ea469] [1346144407.732227531]  (+0.000062909)
>> [000000000e390fa2983f] [1346144407.732486561]  (+0.000259030)
>> [000000000e3a003ef59a] [1346144411.769265916]  (+4.036779355)
>> [000000000e3a00402dde] [1346144411.769345856]  (+0.000079940)
>> [000000000e3a00458822] [1346144411.769696644]  (+0.000350788)
>> [000000000e3a03586436] [1346144411.821264280]  (+0.051567636)
>> [000000000e3a03598dcc] [1346144411.821340462]  (+0.000076182)
>> [000000000e3a035ac596] [1346144411.821420280]  (+0.000079818)
>> [000000000e3b0358576b] [1346144416.116228301]  (+4.294808021)
>> [000000000e3b03598dca] [1346144416.116307756]  (+0.000079455)
>> [000000000e3b035b1870] [1346144416.116408786]  (+0.000101030)
>> [000000000e3c003ee0c3] [1346144420.359195173]  (+4.242786387)
>> [000000000e3c00401228] [1346144420.359273354]  (+0.000078181)
>> [000000000e3c00480297] [1346144420.359793657]  (+0.000520303)
>> [000000000e3c035863f7] [1346144420.411198809]  (+0.051405152)
>> [000000000e3c03598e43] [1346144420.411275173]  (+0.000076364)
>> [000000000e3c035ac6ff] [1346144420.411355233]  (+0.000080060)
>> [000000000e3d03586b4c] [1346144424.706167982]  (+4.294812749)
>> [000000000e3d0359a7d2] [1346144424.706249012]  (+0.000081030)
>> [000000000e3d035b2f28] [1346144424.706349194]  (+0.000100182)
>> [000000000e3e003ee0fb] [1346144428.949129821]  (+4.242780627)
>> [000000000e3e00401317] [1346144428.949208185]  (+0.000078364)
>> [000000000e3e00495a90] [1346144428.949816306]  (+0.000608121)
>> [000000000e3e00f6261f] [1346144428.961140609]  (+0.011324303)
>> [000000000e3e00f79420] [1346144428.961234306]  (+0.000093697)
>> [000000000e3e00f8ba29] [1346144428.961309579]  (+0.000075273)
>> [000000000e3e03586522] [1346144429.001133700]  (+0.039824121)
>> [000000000e3e03598e7b] [1346144429.001209821]  (+0.000076121)
>> [000000000e3e035acd23] [1346144429.001291397]  (+0.000081576)
>> [000000000e3e0d5bc868] [1346144429.169127882]  (+0.167836485)
>> [000000000e3e0d5cf67d] [1346144429.169205215]  (+0.000077333)
>> [000000000e3e0d60bcdf] [1346144429.169452609]  (+0.000247394)
>> [000000000e3e0d645b02] [1346144429.169689700]  (+0.000237091)
>> [000000000e3e0d711730] [1346144429.170524306]  (+0.000834606)
>> [000000000e3e10139fd2] [1346144429.214730548]  (+0.044206242)
>> [000000000e3e10150f7b] [1346144429.214824669]  (+0.000094121)
>> [000000000e3e10190223] [1346144429.215083397]  (+0.000258728)
>> [000000000e3e111413cf] [1346144429.231537457]  (+0.016454060)
>> [000000000e3e11157581] [1346144429.231628003]  (+0.000090546)
>> [000000000e3e11193dc7] [1346144429.231875881]  (+0.000247878)
>> [000000000e3f03586de3] [1346144433.296103237]  (+4.064227356)
>> [000000000e3f03599e93] [1346144433.296181237]  (+0.000078000)
>> [000000000e3f035b2754] [1346144433.296281782]  (+0.000100545)
>> [000000000e40003ee171] [1346144437.539064531]  (+4.242782749)
>> [000000000e400040138c] [1346144437.539142894]  (+0.000078363)
>> [000000000e4000462587] [1346144437.539540713]  (+0.000397819)
>> [000000000e4003586469] [1346144437.591068107]  (+0.051527394)
>> [000000000e4003598f6a] [1346144437.591144652]  (+0.000076545)
>> [000000000e40035ac605] [1346144437.591224167]  (+0.000079515)
>> [000000000e4103585761] [1346144441.886032067]  (+4.294807900)
>> [000000000e4103598b62] [1346144441.886110916]  (+0.000078849)
>> [000000000e41035b16fa] [1346144441.886212188]  (+0.000101272)
>> [000000000e42003ee446] [1346144446.128999848]  (+4.242787660)
>> [000000000e4200401532] [1346144446.129077908]  (+0.000078060)
>> [000000000e420047efd9] [1346144446.129592635]  (+0.000514727)
>> [000000000e420358699b] [1346144446.181004029]  (+0.051411394)
>> [000000000e42035995cc] [1346144446.181080878]  (+0.000076849)
>> [000000000e42035ad0aa] [1346144446.181161484]  (+0.000080606)
>> [000000000e421c23e01f] [1346144446.596991361]  (+0.415829877)
>> [000000000e421c2558c7] [1346144446.597087785]  (+0.000096424)
>> [000000000e421c34e871] [1346144446.598107603]  (+0.001019818)
>> [000000000e421c35d936] [1346144446.598169240]  (+0.000061637)
>> [000000000e421c65189e] [1346144446.601265664]  (+0.003096424)
>> [000000000e421c661b24] [1346144446.601331846]  (+0.000066182)
>> [000000000e421c7fab69] [1346144446.603007179]  (+0.001675333)
>> [000000000e421c86a8f2] [1346144446.603465300]  (+0.000458121)
>> [000000000e421c880aa4] [1346144446.603555846]  (+0.000090546)
>> [000000000e421c8f701b] [1346144446.604040573]  (+0.000484727)
>> [000000000e421c95da63] [1346144446.604460997]  (+0.000420424)
>> [000000000e421c97371c] [1346144446.604550270]  (+0.000089273)
>> [000000000e421ca9fb16] [1346144446.605780088]  (+0.001229818)
>> [000000000e421cb03e8b] [1346144446.606190573]  (+0.000410485)
>> [000000000e421cb1a000] [1346144446.606281058]  (+0.000090485)
>> [000000000e421cb89ab2] [1346144446.606738452]  (+0.000457394)
>> [000000000e421cbefa16] [1346144446.607156088]  (+0.000417636)
>> [000000000e421cc057fe] [1346144446.607245664]  (+0.000089576)
>> [000000000e421cfc3af5] [1346144446.611170391]  (+0.003924727)
>> [000000000e421d02756b] [1346144446.611578573]  (+0.000408182)
>> [000000000e421d03d888] [1346144446.611669482]  (+0.000090909)
>> [000000000e421d0ad063] [1346144446.612126149]  (+0.000456667)
>> [000000000e421d114a0e] [1346144446.612550512]  (+0.000424363)
>> [000000000e421d12a68a] [1346144446.612639724]  (+0.000089212)
>> [000000000e421d2c1cc5] [1346144446.614308391]  (+0.001668667)
>> [000000000e421d3260f0] [1346144446.614719058]  (+0.000410667)
>> [000000000e421d33c44a] [1346144446.614810028]  (+0.000090970)
>> [000000000e421d3abcda] [1346144446.615266876]  (+0.000456848)
>> [000000000e421d410326] [1346144446.615678088]  (+0.000411212)
>> [000000000e421d425f29] [1346144446.615767179]  (+0.000089091)
>> [000000000e421d59acd5] [1346144446.617294391]  (+0.001527212)
>> [000000000e421d5ff7de] [1346144446.617706816]  (+0.000412425)
>> [000000000e421d615f7a] [1346144446.617798876]  (+0.000092060)
>> [000000000e421d6855ad] [1346144446.618255119]  (+0.000456243)
>> [000000000e421d6eb1fd] [1346144446.618671967]  (+0.000416848)
>> [000000000e421d700fe5] [1346144446.618761543]  (+0.000089576)
>> [000000000e421d86f308] [1346144446.620261482]  (+0.001499939)
>> [000000000e421d8d4124] [1346144446.620674694]  (+0.000413212)
>> [000000000e421d8ea405] [1346144446.620765543]  (+0.000090849)
>> [000000000e421da58d13] [1346144446.622266997]  (+0.001501454)
>> [000000000e421dabb0cf] [1346144446.622669361]  (+0.000402364)
>> [000000000e421dad1594] [1346144446.622760694]  (+0.000091333)
>> [000000000e421dc2edac] [1346144446.624192270]  (+0.001431576)
>> [000000000e421dc93edc] [1346144446.624606270]  (+0.000414000)
>> [000000000e421dcaa50d] [1346144446.624697967]  (+0.000091697)
>> [000000000e421e4f0056] [1346144446.633372088]  (+0.008674121)
>> [000000000e421e557e08] [1346144446.633797482]  (+0.000425394)
>> [000000000e421e56e162] [1346144446.633888452]  (+0.000090970)
>> [000000000e421e636796] [1346144446.634709240]  (+0.000820788)
>> [000000000e421e64a7e6] [1346144446.634791240]  (+0.000082000)
>> [000000000e421e6ae404] [1346144446.635199846]  (+0.000408606)
>> [000000000e421e6dafb0] [1346144446.635383058]  (+0.000183212)
>> [000000000e421e6ec24f] [1346144446.635453361]  (+0.000070303)
>> [000000000e421e73ea9f] [1346144446.635791361]  (+0.000338000)
>> [000000000e421e88f797] [1346144446.637170937]  (+0.001379576)
>> [000000000e421e8c65ab] [1346144446.637395725]  (+0.000224788)
>> [000000000e421e8dbcf2] [1346144446.637483604]  (+0.000087879)
>> [000000000e421ea85c85] [1346144446.639228391]  (+0.001744787)
>> [000000000e421ea9c3e5] [1346144446.639320391]  (+0.000092000)
>> [000000000e421eafbeac] [1346144446.639712270]  (+0.000391879)
>> [000000000e421eb7f386] [1346144446.640250088]  (+0.000537818)
>> [000000000e421eb93399] [1346144446.640332027]  (+0.000081939)
>>
>> Since the most significant 32 bits of the timestamp span from 0xe38 to
>> 0xe42, whose difference is exactly 0xa (10 in decimal), I would assume
>> they are somehow representing the uptime in seconds, whereas the least
>> significant 32 bits are (maybe?) really (clock?) cycles.
>> It looks like the maximum value reached by the least significant 32 bits
>> is somewehere near 0x1fff'ffff (so 29 bits as opposed to 32).
>> It's also easy to spot that the huge (4.3 seconds) gaps occur whenever
>> there's an increase in the uppermost 32-bit fraction (0xe38->0xe39,
>> etc...).
>>
>> Anyway, there's definitely something wrong with the way LLTng actually
>> picks up those timestamps.
>> Could someone please spend a few words on how these timestamps are
>> computed on PowerPC?
>>
>> Thanks a lot!
>> Gerlando
>>
>> On 08/28/2012 03:00 PM, Gerlando Falauto wrote:
>>> Hi,
>>>
>>> picking up again from my own message...
>>>
>>> I'm try this again after these few months, and I still get some similar
>>> behavior.
>>> Again, it's a 32-bit PowerPC with 4ms system tick (CONFIG_HZ=250). The
>>> machine has neither NTP nor internal clock, therefore I set a given
>>> timestamp before starting the test.
>>> Traces were generated using the latest master branch of the three
>>> repositories (lttng-modules, lttng-tools, userspace-rcu).
>>>
>>> Running the following script on the target:
>>>
>>> date -s "2012-08-28 09:00:00"
>>> lttng create trace
>>> lttng enable-channel -k mychannel
>>> lttng enable-event sched_switch,sched_wakeup -k -c mychannel
>>> lttng start
>>> echo waiting 10 seconds
>>> sleep 10
>>> lttng stop
>>> lttng destroy trace
>>> date
>>>
>>> (for which I get the following output):
>>>
>>> Tue Aug 28 09:00:00 UTC 2012
>>> Session trace created.
>>> Traces will be written in /root/lttng-traces/trace-20120828-090000
>>> Kernel channel mychannel enabled for session trace
>>> kernel event sched_switch created in channel mychannel
>>> kernel event sched_wakeup created in channel mychannel
>>> Tracing started for session trace
>>> waiting 10 seconds
>>> Tracing stopped for session trace
>>> Session trace destroyed
>>> Tue Aug 28 09:00:10 UTC 2012
>>>
>>> I get the following trace:
>>>
>>> babeltrace --clock-date --clock-gmt
>>> /path/to/root/lttng-traces/trace-20120828-090000/
>>> [2012-08-28 09:00:00.348477307] (+?.?????????) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "mng_clients", prev_tid = 452, prev_prio =
>>> 20, prev_state = 0, next_comm = "cons_recv_fds", next_tid = 461,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.350913974] (+0.002436667) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 0, next_comm = "mng_clients", next_tid = 452, next_prio
>>> = 20 }
>>> [2012-08-28 09:00:00.352444701] (+0.001530727) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 492, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.352584944] (+0.000140243) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "klogd", tid = 385, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.352691186] (+0.000106242) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.352853368] (+0.000162182) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "mng_clients", prev_tid = 452, prev_prio =
>>> 20, prev_state = 0, next_comm = "klogd", next_tid = 385, next_prio = 20 }
>>> [2012-08-28 09:00:00.353377247] (+0.000523879) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "syslogd", tid = 383, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.354078519] (+0.000701272) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "klogd", prev_tid = 385, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:00.354210095] (+0.000131576) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "syslogd", next_tid = 383, next_prio = 20 }
>>> [2012-08-28 09:00:00.355109428] (+0.000899333) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "syslogd", prev_tid = 383, prev_prio = 20,
>>> prev_state = 130, next_comm = "klogd", next_tid = 385, next_prio = 20 }
>>> [2012-08-28 09:00:00.355501731] (+0.000392303) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "syslogd", tid = 383, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.355620519] (+0.000118788) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "klogd", prev_tid = 385, prev_prio = 20,
>>> prev_state = 0, next_comm = "syslogd", next_tid = 383, next_prio = 20 }
>>> [2012-08-28 09:00:00.356259610] (+0.000639091) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "syslogd", prev_tid = 383, prev_prio = 20,
>>> prev_state = 130, next_comm = "klogd", next_tid = 385, next_prio = 20 }
>>> [2012-08-28 09:00:00.356807429] (+0.000547819) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "syslogd", tid = 383, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.357136883] (+0.000329454) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "klogd", prev_tid = 385, prev_prio = 20,
>>> prev_state = 1, next_comm = "syslogd", next_tid = 383, next_prio = 20 }
>>> [2012-08-28 09:00:00.357816762] (+0.000679879) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "syslogd", prev_tid = 383, prev_prio = 20,
>>> prev_state = 130, next_comm = "lttng", next_tid = 492, next_prio = 20 }
>>> [2012-08-28 09:00:00.358233853] (+0.000417091) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "syslogd", tid = 383, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.358371125] (+0.000137272) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 492, prev_prio = 20,
>>> prev_state = 0, next_comm = "syslogd", next_tid = 383, next_prio = 20 }
>>> [2012-08-28 09:00:00.360446034] (+0.002074909) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "syslogd", prev_tid = 383, prev_prio = 20,
>>> prev_state = 1, next_comm = "lttng", next_tid = 492, next_prio = 20 }
>>> [2012-08-28 09:00:00.361265065] (+0.000819031) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "ksoftirqd/0", tid = 3, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.361352459] (+0.000087394) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 492, prev_prio = 20,
>>> prev_state = 0, next_comm = "ksoftirqd/0", next_tid = 3, next_prio = 20 }
>>> [2012-08-28 09:00:00.361385974] (+0.000033515) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 492, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.361461186] (+0.000075212) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "ksoftirqd/0", prev_tid = 3, prev_prio = 20,
>>> prev_state = 1, next_comm = "lttng", next_tid = 492, next_prio = 20 }
>>> [2012-08-28 09:00:00.361540459] (+0.000079273) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "ksoftirqd/0", tid = 3, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.361600641] (+0.000060182) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 492, prev_prio = 20,
>>> prev_state = 0, next_comm = "ksoftirqd/0", next_tid = 3, next_prio = 20 }
>>> [2012-08-28 09:00:00.361685247] (+0.000084606) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "ksoftirqd/0", prev_tid = 3, prev_prio = 20,
>>> prev_state = 1, next_comm = "lttng", next_tid = 492, next_prio = 20 }
>>> [2012-08-28 09:00:00.362983004] (+0.001297757) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 388, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.363067247] (+0.000084243) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 492, prev_prio = 20,
>>> prev_state = 64, next_comm = "sh", next_tid = 388, next_prio = 20 }
>>> [2012-08-28 09:00:00.363663428] (+0.000596181) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "ksoftirqd/0", tid = 3, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.363753004] (+0.000089576) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 388, prev_prio = 20,
>>> prev_state = 0, next_comm = "ksoftirqd/0", next_tid = 3, next_prio = 20 }
>>> [2012-08-28 09:00:00.363788155] (+0.000035151) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 388, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.363856580] (+0.000068425) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "ksoftirqd/0", prev_tid = 3, prev_prio = 20,
>>> prev_state = 1, next_comm = "sh", next_tid = 388, next_prio = 20 }
>>> [2012-08-28 09:00:00.363922519] (+0.000065939) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "ksoftirqd/0", tid = 3, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.364054580] (+0.000132061) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 388, prev_prio = 20,
>>> prev_state = 0, next_comm = "ksoftirqd/0", next_tid = 3, next_prio = 20 }
>>> [2012-08-28 09:00:00.364119004] (+0.000064424) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "ksoftirqd/0", prev_tid = 3, prev_prio = 20,
>>> prev_state = 1, next_comm = "sh", next_tid = 388, next_prio = 20 }
>>> [2012-08-28 09:00:00.366897247] (+0.002778243) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 388, prev_prio = 20,
>>> prev_state = 0, next_comm = "cons_recv_fds", next_tid = 461, next_prio =
>>> 20 }
>>> [2012-08-28 09:00:00.367404640] (+0.000507393) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 1, next_comm = "sh", next_tid = 388, next_prio = 20 }
>>> [2012-08-28 09:00:00.367605549] (+0.000200909) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 388, prev_prio = 20,
>>> prev_state = 1, next_comm = "mng_clients", next_tid = 452, next_prio = 20 }
>>> [2012-08-28 09:00:00.367966701] (+0.000361152) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "mng_clients", prev_tid = 452, prev_prio =
>>> 20, prev_state = 1, next_comm = "sh", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:00.369751065] (+0.001784364) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 495, prev_prio = 20,
>>> prev_state = 130, next_comm = "cons_recv_fds", next_tid = 494, next_prio
>>> = 20 }
>>> [2012-08-28 09:00:00.370164277] (+0.000413212) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 495, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.371547186] (+0.001382909) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 494, prev_prio =
>>> 20, prev_state = 130, next_comm = "sh", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:00.371978216] (+0.000431030) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 494, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.372420277] (+0.000442061) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 495, prev_prio = 20,
>>> prev_state = 130, next_comm = "cons_recv_fds", next_tid = 494, next_prio
>>> = 20 }
>>> [2012-08-28 09:00:00.372877853] (+0.000457576) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 495, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.373435004] (+0.000557151) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 494, prev_prio =
>>> 20, prev_state = 130, next_comm = "sh", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:00.373916641] (+0.000481637) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 494, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.374868943] (+0.000952302) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 495, prev_prio = 20,
>>> prev_state = 130, next_comm = "cons_recv_fds", next_tid = 494, next_prio
>>> = 20 }
>>> [2012-08-28 09:00:00.375289610] (+0.000420667) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 495, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.375731186] (+0.000441576) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 494, prev_prio =
>>> 20, prev_state = 130, next_comm = "sh", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:00.376117428] (+0.000386242) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 494, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.378842034] (+0.002724606) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sleep", prev_tid = 495, prev_prio = 20,
>>> prev_state = 0, next_comm = "cons_recv_fds", next_tid = 494, next_prio =
>>> 20 }
>>> [2012-08-28 09:00:00.379333671] (+0.000491637) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 494, prev_prio =
>>> 20, prev_state = 130, next_comm = "sleep", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:00.380850217] (+0.001516546) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sleep", prev_tid = 495, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:00.381269065] (+0.000418848) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sleep", tid = 495, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:00.381361004] (+0.000091939) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "sleep", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:00.386596822] (+0.005235818) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sleep", prev_tid = 495, prev_prio = 20,
>>> prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:00.394262762] (+0.007665940) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 494, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.394357368] (+0.000094606) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "cons_recv_fds", next_tid = 494, next_prio =
>>> 20 }
>>> [2012-08-28 09:00:00.394719974] (+0.000362606) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 461, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.395709549] (+0.000989575) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 494, prev_prio =
>>> 20, prev_state = 64, next_comm = "cons_recv_fds", next_tid = 461,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.396408701] (+0.000699152) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_poll_fds", tid = 462, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.398866640] (+0.002457939) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 0, next_comm = "cons_poll_fds", next_tid = 462,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.398973428] (+0.000106788) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_poll_fds", prev_tid = 462, prev_prio =
>>> 20, prev_state = 2, next_comm = "cons_recv_fds", next_tid = 461,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.399076034] (+0.000102606) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_poll_fds", tid = 462, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.399131186] (+0.000055152) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 0, next_comm = "cons_poll_fds", next_tid = 462,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.401086701] (+0.001955515) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_poll_fds", prev_tid = 462, prev_prio =
>>> 20, prev_state = 1, next_comm = "cons_recv_fds", next_tid = 461,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.401670216] (+0.000583515) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 1, next_comm = "cons_recv_fds", next_tid = 496,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.402858156] (+0.001187940) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 496, prev_prio =
>>> 20, prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:00.403272398] (+0.000414242) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 496, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.403363852] (+0.000091454) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "cons_recv_fds", next_tid = 496, next_prio =
>>> 20 }
>>> [2012-08-28 09:00:00.403830277] (+0.000466425) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 496, prev_prio =
>>> 20, prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:00.404193731] (+0.000363454) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 496, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.404283852] (+0.000090121) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "cons_recv_fds", next_tid = 496, next_prio =
>>> 20 }
>>> [2012-08-28 09:00:00.404909247] (+0.000625395) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 496, prev_prio =
>>> 20, prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:00.405407065] (+0.000497818) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 496, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.405496823] (+0.000089758) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "cons_recv_fds", next_tid = 496, next_prio =
>>> 20 }
>>> [2012-08-28 09:00:00.405854156] (+0.000357333) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 461, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.405938822] (+0.000084666) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 496, prev_prio =
>>> 20, prev_state = 0, next_comm = "cons_recv_fds", next_tid = 461,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.406084095] (+0.000145273) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 1, next_comm = "cons_recv_fds", next_tid = 496,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.407004519] (+0.000920424) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_recv_fds", tid = 461, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.407075186] (+0.000070667) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 496, prev_prio =
>>> 20, prev_state = 64, next_comm = "cons_recv_fds", next_tid = 461,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.407706034] (+0.000630848) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "cons_poll_fds", tid = 462, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:00.407897368] (+0.000191334) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_recv_fds", prev_tid = 461, prev_prio =
>>> 20, prev_state = 1, next_comm = "cons_poll_fds", next_tid = 462,
>>> next_prio = 20 }
>>> [2012-08-28 09:00:00.408304580] (+0.000407212) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "cons_poll_fds", prev_tid = 462, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:04.547552602] (+4.139248022) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:04.547632966] (+0.000080364) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:04.547736542] (+0.000103576) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:04.691537693] (+0.143801151) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "flush-0:14", tid = 389, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:04.691615027] (+0.000077334) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "flush-0:14", next_tid = 389, next_prio = 20 }
>>> [2012-08-28 09:00:04.691705269] (+0.000090242) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "flush-0:14", prev_tid = 389, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:05.311535024] (+0.619829755) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:05.311613084] (+0.000078060) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:05.311882903] (+0.000269819) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:08.842504805] (+3.530621902) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:08.842583350] (+0.000078545) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:08.842664562] (+0.000081212) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:08.994502865] (+0.151838303) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:08.994581229] (+0.000078364) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:08.994670441] (+0.000089212) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:13.137477252] (+4.142806811) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:13.137557191] (+0.000079939) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:13.137656101] (+0.000098910) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:13.901469492] (+0.763813391) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:13.901548037] (+0.000078545) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:13.902056037] (+0.000508000) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:13.905507067] (+0.003451030) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sync_supers", tid = 76, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:13.905589916] (+0.000082849) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "sync_supers", next_tid = 76, next_prio = 20 }
>>> [2012-08-28 09:00:13.905661613] (+0.000071697) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sync_supers", prev_tid = 76, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:17.432437394] (+3.526775781) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:17.432515636] (+0.000078242) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:17.432599636] (+0.000084000) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:21.727404869] (+4.294805233) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:21.727485232] (+0.000080363) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:21.727587050] (+0.000101818) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:22.491405717] (+0.763818667) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:22.491484384] (+0.000078667) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:22.491873414] (+0.000389030) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:26.022372104] (+3.530498690) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:26.022450467] (+0.000078363) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:26.022531134] (+0.000080667) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:26.166376770] (+0.143845636) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "flush-0:14", tid = 389, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:26.166453558] (+0.000076788) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "flush-0:14", next_tid = 389, next_prio = 20 }
>>> [2012-08-28 09:00:26.166543558] (+0.000090000) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "flush-0:14", prev_tid = 389, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:30.317347278] (+4.150803720) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:30.317427399] (+0.000080121) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:30.317528550] (+0.000101151) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:31.081338729] (+0.763810179) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:31.081417759] (+0.000079030) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:31.081881335] (+0.000463576) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:34.612306086] (+3.530424751) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:34.612384571] (+0.000078485) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:34.612465116] (+0.000080545) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:38.907282170] (+4.294817054) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:38.907362109] (+0.000079939) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:38.907461442] (+0.000099333) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:39.622817924] (+0.715356482) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "syslogd", tid = 383, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:39.622887803] (+0.000069879) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "syslogd", next_tid = 383, next_prio = 20 }
>>> [2012-08-28 09:00:39.623148106] (+0.000260303) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "syslogd", prev_tid = 383, prev_prio = 20,
>>> prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:39.671276530] (+0.048128424) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:39.671355864] (+0.000079334) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:39.671687682] (+0.000331818) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:39.675311742] (+0.003624060) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sync_supers", tid = 76, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:39.675394409] (+0.000082667) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "sync_supers", next_tid = 76, next_prio = 20 }
>>> [2012-08-28 09:00:39.675466288] (+0.000071879) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sync_supers", prev_tid = 76, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.202240735] (+3.526774447) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "kworker/0:1", tid = 99, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.202318857] (+0.000078122) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "kworker/0:1", next_tid = 99, next_prio = 20 }
>>> [2012-08-28 09:00:43.202402250] (+0.000083393) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "kworker/0:1", prev_tid = 99, prev_prio =
>>> 20, prev_state = 1, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.346233038] (+0.143830788) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sleep", tid = 495, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.346330614] (+0.000097576) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "sleep", next_tid = 495, next_prio = 20 }
>>> [2012-08-28 09:00:43.347314432] (+0.000983818) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 388, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.347383644] (+0.000069212) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sleep", prev_tid = 495, prev_prio = 20,
>>> prev_state = 64, next_comm = "sh", next_tid = 388, next_prio = 20 }
>>> [2012-08-28 09:00:43.349999825] (+0.002616181) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 388, prev_prio = 20,
>>> prev_state = 1, next_comm = "sh", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.351726735] (+0.001726910) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.352191159] (+0.000464424) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.352283038] (+0.000091879) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "sh", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.353304492] (+0.001021454) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "sh", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.353711038] (+0.000406546) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "sh", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.353802856] (+0.000091818) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "sh", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.357738795] (+0.003935939) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.358151644] (+0.000412849) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.358400311] (+0.000248667) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.358873644] (+0.000473333) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.359283644] (+0.000410000) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.359375523] (+0.000091879) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.360845098] (+0.001469575) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.361246492] (+0.000401394) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.361338977] (+0.000092485) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.361800674] (+0.000461697) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.362320250] (+0.000519576) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.362479463] (+0.000159213) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.363838068] (+0.001358605) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.364240553] (+0.000402485) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.364332553] (+0.000092000) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.364792189] (+0.000459636) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.365205038] (+0.000412849) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.365296916] (+0.000091878) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.366988129] (+0.001691213) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.367399705] (+0.000411576) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.367492371] (+0.000092666) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.368825704] (+0.001333333) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.369229038] (+0.000403334) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.369321280] (+0.000092242) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.370950675] (+0.001629395) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.371353220] (+0.000402545) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.371445462] (+0.000092242) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.380016917] (+0.008571455) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.380428129] (+0.000411212) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.380521159] (+0.000093030) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.381335462] (+0.000814303) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "mng_clients", tid = 452, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:43.381420795] (+0.000085333) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 0, next_comm = "mng_clients", next_tid = 452, next_prio = 20 }
>>> [2012-08-28 09:00:43.381826250] (+0.000405455) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "mng_clients", prev_tid = 452, prev_prio =
>>> 20, prev_state = 1, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.382007038] (+0.000180788) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "mng_clients", tid = 452, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:43.382081522] (+0.000074484) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 0, next_comm = "mng_clients", next_tid = 452, next_prio = 20 }
>>> [2012-08-28 09:00:43.382528190] (+0.000446668) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "mng_clients", prev_tid = 452, prev_prio =
>>> 20, prev_state = 1, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.383627341] (+0.001099151) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 130, next_comm = "swapper", next_tid = 0, next_prio = 20 }
>>> [2012-08-28 09:00:43.384035280] (+0.000407939) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "lttng", tid = 497, prio = 120, success = 1,
>>> target_cpu = 0 }
>>> [2012-08-28 09:00:43.384128189] (+0.000092909) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "swapper", prev_tid = 0, prev_prio = 20,
>>> prev_state = 0, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.385790613] (+0.001662424) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "mng_clients", tid = 452, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:43.385877704] (+0.000087091) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 0, next_comm = "mng_clients", next_tid = 452, next_prio = 20 }
>>> [2012-08-28 09:00:43.386442190] (+0.000564486) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "mng_clients", prev_tid = 452, prev_prio =
>>> 20, prev_state = 1, next_comm = "lttng", next_tid = 497, next_prio = 20 }
>>> [2012-08-28 09:00:43.386978008] (+0.000535818) mgcoge3ne sched_wakeup: {
>>> cpu_id = 0 }, { comm = "mng_clients", tid = 452, prio = 120, success =
>>> 1, target_cpu = 0 }
>>> [2012-08-28 09:00:43.387074129] (+0.000096121) mgcoge3ne sched_switch: {
>>> cpu_id = 0 }, { prev_comm = "lttng", prev_tid = 497, prev_prio = 20,
>>> prev_state = 0, next_comm = "mng_clients", next_tid = 452, next_prio = 20 }
>>>
>>> So again, I get these huge 3.3 (or so) seconds gaps, and a final
>>> timestamp which is 43 seconds instead of the 10 seconds which actually
>>> went by.
>>>
>>> BTW, I also tried with TMF under Eclipse, and here I get even weirder
>>> results. Here's a table of correspondence (as there must be some occult
>>> side to it!) for the timestamps as reported by babeltrace vs. Eclipse:
>>>
>>> [2012-08-28 09:00:00.348477307] ->  2033-05-07 16:49:22.035276997
>>> ...
>>> [2012-08-28 09:00:00.408304580] ->  2033-05-07 16:49:22.112912324
>>> ....
>>> [2012-08-28 09:00:04.691537693] ->  2039-11-23 09:06:50.748861638
>>>
>>> Under Eclipse, the latest event of this 10-second trace lies sometime
>>> within year 2124.
>>>
>>> No clue, anyone?
>>>
>>> Thank you,
>>> Gerlando
>>>
>>> On 12/16/2011 11:15 AM, Gerlando Falauto wrote:
>>>> Hi,
>>>>
>>>> I am trying to use LLTng 2.0 (since I have no alternative for a 3.0
>>>> kernel!) and I of course use babeltrace to read them.
>>>> Problem is, I can't make any sense out of the timestamps, as I get
>>>> something like (two CPU-hog bash processes):
>>>>
>>>> [1658841591493] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 647, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 646,
>>>> next_prio = 20 }
>>>> [1658845590645] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 647,
>>>> next_prio = 20 }
>>>> [1658849590039] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 647, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 646,
>>>> next_prio = 20 }
>>>> [1658853591069] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 647,
>>>> next_prio = 20 }
>>>> [1662152559395] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 647, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 646,
>>>> next_prio = 20 }
>>>> [1662156587941] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 647,
>>>> next_prio = 20 }
>>>> [1662160557698] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 647, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 646,
>>>> next_prio = 20 }
>>>> [1662164557517] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 647,
>>>> next_prio = 20 }
>>>> [....................................cut...........................]
>>>> [1663140553029] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 647,
>>>> next_prio = 20 }
>>>> [1663144555029] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 647, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 646,
>>>> next_prio = 20 }
>>>> [1663148552423] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 647,
>>>> next_prio = 20 }
>>>> [1666447519719] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 647, prev_prio = 20, prev_state = 0, next_comm = "bash", next_tid = 646,
>>>> next_prio = 20 }
>>>> [1666451561355] sched_switch: { 0 }, { prev_comm = "bash", prev_tid =
>>>> 646, prev_prio = 20, prev_state = 0, next_comm = "kworker/0:1", next_tid
>>>> = 94, next_prio = 20 }
>>>> [1666451863719] sched_switch: { 0 }, { prev_comm = "kworker/0:1",
>>>> prev_tid = 94, prev_prio = 20, prev_state = 1, next_comm = "bash",
>>>> next_tid = 647, next_prio = 20 }
>>>>
>>>> Which made me think timestamps were expressed in nanoseconds, as I am
>>>> running this on 4ms-tick PowerPC (CONFIG_HZ=250), and the difference
>>>> between timestamps is approximately 4,000,000.
>>>> However, I get these huge 3.3 second gaps between for instance between
>>>> 1658853591069 and 1662152559395.
>>>> Curiously enough, these leap 3.3 seconds occur exactly (well, within 4ms
>>>> precision...) every second. Kind of like the "seconds" part of the
>>>> timestamp is calculated on a wrong-base arithmetics or so....
>>>> This also makes sense as the seconds' portion of the timestamp is
>>>> essentially 4.3 times bigger than the uptime (and any time stretch is
>>>> 4.3 times bigger than reality, for that matter).
>>>>
>>>> Any suggestions?
>>>>
>>>> Thanks!
>>>> Gerlando
>>>>
>>>> P.S. This also happens without my hack for flight recording mode...
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
