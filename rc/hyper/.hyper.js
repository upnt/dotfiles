module.exports = {
	config: {
		updateChannel: 'stable',
		fontSize: 14,
		fontFamily: "HackGen35 Console NF",
		unibody: 'false',
		padding: '0px 4px 18px',
		hyperline: {
			plugins: [
				"hostname",
				"ip",
				"memory",
				"cpu",
			],
		},
	},
	plugins: [
		'hyper-gruvbox-material',
		'hyper-tab-icons-plus',
		'hyperline',
	],
};
