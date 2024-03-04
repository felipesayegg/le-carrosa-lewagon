import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fipe"
export default class extends Controller {
  connect() {
    console.log('conectado')
    this.updateBrands();
  }

  updateBrands() {
    const brandSelect = document.getElementById('brand_select');
    const modelSelect = document.getElementById('model_select');
    const yearSelect = document.getElementById('year_select');

    // Limpar opções anteriores
    brandSelect.innerHTML = '';
    modelSelect.innerHTML = '';
    yearSelect.innerHTML = '';


    // Consulta à API para obter marcas de carros
    fetch(`https://parallelum.com.br/fipe/api/v1/carros/marcas/`)
      .then(response => response.json())
      .then(data => {
        data.forEach(brand => {
          brandSelect.insertAdjacentHTML('beforeend', `<option value="${brand.codigo}">${brand.nome}</option>`);
        });
      })
      .catch(error => console.error('Error fetching brands:', error));
  }

  updateModels() {
    const brand = document.getElementById('brand_select');
    const modelSelect = document.getElementById('model_select');
    const yearSelect = document.getElementById('year_select');

    // Limpar opções anteriores
    modelSelect.innerHTML = '';
    yearSelect.innerHTML = '';

    // Consulta à API para obter modelos de carros
    fetch(`https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.value}/Modelos`)
      .then(response => response.json())
      .then(data => {
        data.modelos.forEach(model => {
          modelSelect.insertAdjacentHTML('beforeend', `<option value="${model.codigo}">${model.nome}</option>`);
        });
      })
      .catch(error => console.error('Error fetching models:', error));
  }

  updateYears() {
    const brand = document.getElementById('brand_select');
    const modelId = document.getElementById('model_select');
    const yearSelect = document.getElementById('year_select');
    const priceSelect = document.getElementById('price_select');

    // Limpar opções anteriores
    yearSelect.innerHTML = '';
    priceSelect.innerHTML = '';

    // Consulta à API para obter anos do modelo selecionado
    fetch(`https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.value}/Modelos/${modelId.value}/Anos`)
      .then(response => response.json())
      .then(data => {
        data.forEach(year => {
          yearSelect.insertAdjacentHTML('beforeend', `<option name=${year.nome} value=${year.codigo}>${year.nome.substring(0, 4)}</option>`);
        });
      })
      .catch(error => console.error('Error fetching years:', error));
  }

  updatePrice() {
    const brand = document.getElementById('brand_select');
    const modelId = document.getElementById('model_select');
    const yearSelect = document.getElementById('year_select');
    const priceSelect = document.getElementById('price_select');

    priceSelect.innerHTML = '';


    // Consulta à API para obter o valor da fipe
    fetch(`https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.value}/Modelos/${modelId.value}/Anos/${yearSelect.value}`)
      .then(response => response.json())
      .then(data => {
        priceSelect.innerHTML = `<strong>Valor sugerido pela FIPE: </strong>${data.Valor}`;
      })
      .catch(error => console.error('Error fetching years:', error));
  }
}
