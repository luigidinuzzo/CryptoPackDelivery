import Web3 from 'web3';
import configuration from '../build/contracts/PackDeliver.json';
import './node_modules/bootstrap/dist/css/bootstrap.css';

const createElementFromString = (string) => {
  const el = document.createElement('div');
  el.innerHTML = string;
  return el.firstChild;
};

const CONTRACT_ADDRESS =
  configuration.networks['5777'].address;
const CONTRACT_ABI = configuration.abi;

const web3 = new Web3(
  Web3.givenProvider || 'http://127.0.0.1:7545'
);
const contract = new web3.eth.Contract(
  CONTRACT_ABI,
  CONTRACT_ADDRESS
);

let account;

const accountEl = document.getElementById('account');
const invia = document.getElementById('invia');

const EMPTY_ADDRESS =
  '0x0000000000000000000000000000000000000000';

const createPackForm = async () => {
  const receiver = document.getElementById('receiver').value;
  const num = document.getElementById('num').value;
  const lat = document.getElementById('lat').value;
  const long = document.getElementById('long').value;
  contract.methods
    .createPack(receiver, num, lat, long).send({ from: account });
};

const main = async () => {
  const accounts = await web3.eth.requestAccounts();
  account = accounts[0];
  accountEl.innerText = account;
  invia.onclick = createPackForm;
};

main();